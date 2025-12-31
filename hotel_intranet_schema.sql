-- Supabase PostgreSQL Schema for Sunny Hotel Staff Intranet System
-- Generated for 25-room hotel with 30 staff members

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Enums
CREATE TYPE user_role AS ENUM ('front_desk', 'housekeeping', 'maintenance', 'department_manager', 'general_manager', 'night_manager');
CREATE TYPE room_status AS ENUM ('clean', 'dirty', 'occupied', 'maintenance', 'reserved', 'out_of_order');
CREATE TYPE task_status AS ENUM ('pending', 'in_progress', 'completed', 'cancelled');
CREATE TYPE priority_level AS ENUM ('low', 'medium', 'high', 'urgent');
CREATE TYPE room_type AS ENUM ('standard', 'deluxe', 'suite', 'executive');
CREATE TYPE announcement_type AS ENUM ('general', 'urgent', 'department', 'shift_change');
CREATE TYPE document_type AS ENUM ('policy', 'procedure', 'training', 'safety', 'maintenance_log', 'guest_info');

-- Users table (staff members)
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    employee_id VARCHAR(10) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role user_role NOT NULL,
    department VARCHAR(50),
    is_active BOOLEAN DEFAULT true,
    pin_hash VARCHAR(255), -- For PIN-based authentication
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Rooms table
CREATE TABLE rooms (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    room_number VARCHAR(10) UNIQUE NOT NULL,
    floor INTEGER NOT NULL,
    room_type room_type NOT NULL,
    status room_status DEFAULT 'clean',
    max_occupancy INTEGER DEFAULT 2,
    amenities TEXT[], -- Array of amenities
    notes TEXT,
    last_cleaned TIMESTAMP WITH TIME ZONE,
    last_maintenance TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Housekeeping tasks table
CREATE TABLE housekeeping_tasks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    room_id UUID NOT NULL REFERENCES rooms(id) ON DELETE CASCADE,
    assigned_to UUID REFERENCES users(id) ON DELETE SET NULL,
    created_by UUID NOT NULL REFERENCES users(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status task_status DEFAULT 'pending',
    priority priority_level DEFAULT 'medium',
    estimated_duration INTERVAL, -- e.g., '30 minutes'
    scheduled_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Maintenance requests table
CREATE TABLE maintenance_requests (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    room_id UUID REFERENCES rooms(id) ON DELETE SET NULL,
    requested_by UUID NOT NULL REFERENCES users(id),
    assigned_to UUID REFERENCES users(id) ON DELETE SET NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    status task_status DEFAULT 'pending',
    priority priority_level DEFAULT 'medium',
    category VARCHAR(100), -- e.g., 'plumbing', 'electrical', 'HVAC'
    photos TEXT[], -- Array of photo URLs or file paths
    estimated_cost DECIMAL(10,2),
    completed_at TIMESTAMP WITH TIME ZONE,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Announcements table
CREATE TABLE announcements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    announcement_type announcement_type DEFAULT 'general',
    created_by UUID NOT NULL REFERENCES users(id),
    target_departments user_role[], -- Array of roles to target, NULL for all
    is_active BOOLEAN DEFAULT true,
    expires_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Announcement read status table
CREATE TABLE announcement_reads (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    announcement_id UUID NOT NULL REFERENCES announcements(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    read_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(announcement_id, user_id)
);

-- Documents table
CREATE TABLE documents (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    document_type document_type NOT NULL,
    file_path VARCHAR(500) NOT NULL, -- Supabase Storage path
    file_size INTEGER,
    mime_type VARCHAR(100),
    uploaded_by UUID NOT NULL REFERENCES users(id),
    is_public BOOLEAN DEFAULT false,
    tags TEXT[], -- Array of tags for search
    version INTEGER DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Push notifications tokens table
CREATE TABLE push_tokens (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token TEXT NOT NULL,
    device_type VARCHAR(50) DEFAULT 'web',
    is_active BOOLEAN DEFAULT true,
    last_used TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, token)
);

-- Notifications log table
CREATE TABLE notification_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID REFERENCES users(id) ON DELETE SET NULL,
    type VARCHAR(50) NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    target_users UUID[],
    target_roles user_role[],
    sent_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Task history/log table for audit trail
CREATE TABLE task_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    task_type VARCHAR(50) NOT NULL, -- 'housekeeping' or 'maintenance'
    task_id UUID NOT NULL, -- References housekeeping_tasks.id or maintenance_requests.id
    user_id UUID NOT NULL REFERENCES users(id),
    action VARCHAR(100) NOT NULL, -- e.g., 'created', 'assigned', 'completed'
    old_status task_status,
    new_status task_status,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_department ON users(department);
CREATE INDEX idx_users_active ON users(is_active);

CREATE INDEX idx_rooms_status ON rooms(status);
CREATE INDEX idx_rooms_floor ON rooms(floor);
CREATE INDEX idx_rooms_type ON rooms(room_type);

CREATE INDEX idx_housekeeping_tasks_room_id ON housekeeping_tasks(room_id);
CREATE INDEX idx_housekeeping_tasks_assigned_to ON housekeeping_tasks(assigned_to);
CREATE INDEX idx_housekeeping_tasks_status ON housekeeping_tasks(status);
CREATE INDEX idx_housekeeping_tasks_priority ON housekeeping_tasks(priority);
CREATE INDEX idx_housekeeping_tasks_scheduled_at ON housekeeping_tasks(scheduled_at);

CREATE INDEX idx_maintenance_requests_room_id ON maintenance_requests(room_id);
CREATE INDEX idx_maintenance_requests_assigned_to ON maintenance_requests(assigned_to);
CREATE INDEX idx_maintenance_requests_status ON maintenance_requests(status);
CREATE INDEX idx_maintenance_requests_priority ON maintenance_requests(priority);
CREATE INDEX idx_maintenance_requests_category ON maintenance_requests(category);

CREATE INDEX idx_announcements_type ON announcements(announcement_type);
CREATE INDEX idx_announcements_active ON announcements(is_active);
CREATE INDEX idx_announcements_expires_at ON announcements(expires_at);

CREATE INDEX idx_documents_type ON documents(document_type);
CREATE INDEX idx_documents_uploaded_by ON documents(uploaded_by);
CREATE INDEX idx_documents_public ON documents(is_public);

CREATE INDEX idx_task_history_task_type ON task_history(task_type);
CREATE INDEX idx_task_history_task_id ON task_history(task_id);
CREATE INDEX idx_task_history_user_id ON task_history(user_id);

-- Row Level Security (RLS) policies for Supabase
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE rooms ENABLE ROW LEVEL SECURITY;
ALTER TABLE housekeeping_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE maintenance_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE announcements ENABLE ROW LEVEL SECURITY;
ALTER TABLE announcement_reads ENABLE ROW LEVEL SECURITY;
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE push_tokens ENABLE ROW LEVEL SECURITY;
ALTER TABLE notification_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE task_history ENABLE ROW LEVEL SECURITY;

-- NOTIFICATION LOGS POLICIES
-- Managers can view all notification logs
CREATE POLICY "notification_logs_select_managers" ON notification_logs FOR SELECT USING (is_manager());
-- Users can view notification logs they sent
CREATE POLICY "notification_logs_select_own" ON notification_logs FOR SELECT USING (sender_id = auth.uid());

-- ANNOUNCEMENT READS POLICIES
-- Users can manage their own read status
CREATE POLICY "announcement_reads_all_own" ON announcement_reads FOR ALL USING (auth.uid() = user_id);

-- PUSH TOKENS POLICIES
-- Users can manage their own tokens
CREATE POLICY "push_tokens_all_own" ON push_tokens FOR ALL USING (auth.uid() = user_id);

-- Helper function to get current user's role
CREATE OR REPLACE FUNCTION auth_user_role()
RETURNS user_role AS $$
BEGIN
    RETURN (SELECT role FROM users WHERE id = auth.uid());
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to check if user is manager
CREATE OR REPLACE FUNCTION is_manager()
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM users
        WHERE id = auth.uid()
        AND role IN ('department_manager', 'general_manager', 'night_manager')
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to check if user is admin
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM users
        WHERE id = auth.uid()
        AND role = 'general_manager'
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- USERS TABLE POLICIES
-- Users can view and update their own profile
CREATE POLICY "users_select_own" ON users FOR SELECT USING (auth.uid() = id);
CREATE POLICY "users_update_own" ON users FOR UPDATE USING (auth.uid() = id);

-- Managers can view all users, General Manager can do everything
CREATE POLICY "users_select_managers" ON users FOR SELECT USING (is_manager());
CREATE POLICY "users_insert_admin" ON users FOR INSERT WITH CHECK (is_admin());
CREATE POLICY "users_update_admin" ON users FOR UPDATE USING (is_admin());
CREATE POLICY "users_delete_admin" ON users FOR DELETE USING (is_admin());

-- ROOMS TABLE POLICIES
-- All active staff can view rooms
CREATE POLICY "rooms_select_all_staff" ON rooms FOR SELECT USING (
    EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND is_active = true)
);

-- Housekeeping can update room status (clean/dirty transitions)
CREATE POLICY "rooms_update_housekeeping" ON rooms FOR UPDATE USING (
    auth_user_role() = 'housekeeping'
    AND (
        (OLD.status IN ('occupied', 'maintenance') AND NEW.status IN ('dirty', 'clean')) OR
        (OLD.status = 'dirty' AND NEW.status = 'clean')
    )
);

-- Maintenance can update room status for maintenance-related changes
CREATE POLICY "rooms_update_maintenance" ON rooms FOR UPDATE USING (
    auth_user_role() = 'maintenance'
    AND (
        (OLD.status IN ('clean', 'dirty', 'occupied') AND NEW.status IN ('maintenance', 'out_of_order')) OR
        (OLD.status IN ('maintenance', 'out_of_order') AND NEW.status IN ('clean', 'dirty'))
    )
);

-- Front desk can update reservation status
CREATE POLICY "rooms_update_front_desk" ON rooms FOR UPDATE USING (
    auth_user_role() = 'front_desk'
    AND (
        (OLD.status IN ('clean', 'dirty') AND NEW.status = 'reserved') OR
        (OLD.status = 'reserved' AND NEW.status IN ('clean', 'occupied'))
    )
);

-- Managers can update all room information
CREATE POLICY "rooms_update_managers" ON rooms FOR UPDATE USING (is_manager());
CREATE POLICY "rooms_insert_managers" ON rooms FOR INSERT WITH CHECK (is_manager());
CREATE POLICY "rooms_delete_managers" ON rooms FOR DELETE USING (is_manager());

-- HOUSEKEEPING TASKS POLICIES
-- Housekeeping staff can view tasks assigned to them or created by them
CREATE POLICY "housekeeping_tasks_select_housekeeping" ON housekeeping_tasks FOR SELECT USING (
    auth_user_role() = 'housekeeping'
    AND (assigned_to = auth.uid() OR created_by = auth.uid())
);

-- Housekeeping can create tasks
CREATE POLICY "housekeeping_tasks_insert_housekeeping" ON housekeeping_tasks FOR INSERT WITH CHECK (
    auth_user_role() = 'housekeeping'
);

-- Housekeeping can update tasks assigned to them
CREATE POLICY "housekeeping_tasks_update_housekeeping" ON housekeeping_tasks FOR UPDATE USING (
    auth_user_role() = 'housekeeping'
    AND assigned_to = auth.uid()
);

-- Managers can view all housekeeping tasks
CREATE POLICY "housekeeping_tasks_select_managers" ON housekeeping_tasks FOR SELECT USING (is_manager());

-- Managers can create, update, and assign all tasks
CREATE POLICY "housekeeping_tasks_insert_managers" ON housekeeping_tasks FOR INSERT WITH CHECK (is_manager());
CREATE POLICY "housekeeping_tasks_update_managers" ON housekeeping_tasks FOR UPDATE USING (is_manager());
CREATE POLICY "housekeeping_tasks_delete_managers" ON housekeeping_tasks FOR DELETE USING (is_manager());

-- MAINTENANCE REQUESTS POLICIES
-- All staff can create maintenance requests
CREATE POLICY "maintenance_requests_insert_all_staff" ON maintenance_requests FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND is_active = true)
);

-- Staff can view requests they created
CREATE POLICY "maintenance_requests_select_own" ON maintenance_requests FOR SELECT USING (
    requested_by = auth.uid()
);

-- Maintenance staff can view and update all maintenance requests
CREATE POLICY "maintenance_requests_select_maintenance" ON maintenance_requests FOR SELECT USING (
    auth_user_role() = 'maintenance'
);
CREATE POLICY "maintenance_requests_update_maintenance" ON maintenance_requests FOR UPDATE USING (
    auth_user_role() = 'maintenance'
);

-- Managers can view all maintenance requests
CREATE POLICY "maintenance_requests_select_managers" ON maintenance_requests FOR SELECT USING (is_manager());
CREATE POLICY "maintenance_requests_update_managers" ON maintenance_requests FOR UPDATE USING (is_manager());
CREATE POLICY "maintenance_requests_delete_managers" ON maintenance_requests FOR DELETE USING (is_manager());

-- ANNOUNCEMENTS POLICIES
-- All active staff can view announcements targeted to them or general announcements
CREATE POLICY "announcements_select_all_staff" ON announcements FOR SELECT USING (
    EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND is_active = true)
    AND (
        target_departments IS NULL OR
        auth_user_role() = ANY(target_departments) OR
        is_manager()
    )
    AND is_active = true
    AND (expires_at IS NULL OR expires_at > NOW())
);

-- Managers can create announcements
CREATE POLICY "announcements_insert_managers" ON announcements FOR INSERT WITH CHECK (is_manager());

-- Managers can update and delete announcements they created
CREATE POLICY "announcements_update_managers" ON announcements FOR UPDATE USING (
    is_manager() AND created_by = auth.uid()
);
CREATE POLICY "announcements_delete_managers" ON announcements FOR DELETE USING (
    is_manager() AND created_by = auth.uid()
);

-- General Manager can manage all announcements
CREATE POLICY "announcements_update_admin" ON announcements FOR UPDATE USING (is_admin());
CREATE POLICY "announcements_delete_admin" ON announcements FOR DELETE USING (is_admin());

-- DOCUMENTS POLICIES
-- All staff can view public documents
CREATE POLICY "documents_select_public" ON documents FOR SELECT USING (
    is_public = true
    AND EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND is_active = true)
);

-- Staff can view documents they uploaded
CREATE POLICY "documents_select_own" ON documents FOR SELECT USING (
    uploaded_by = auth.uid()
);

-- Staff can upload documents
CREATE POLICY "documents_insert_staff" ON documents FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND is_active = true)
);

-- Staff can update their own documents
CREATE POLICY "documents_update_own" ON documents FOR UPDATE USING (
    uploaded_by = auth.uid()
);

-- Managers can view all documents
CREATE POLICY "documents_select_managers" ON documents FOR SELECT USING (is_manager());
CREATE POLICY "documents_update_managers" ON documents FOR UPDATE USING (is_manager());
CREATE POLICY "documents_delete_managers" ON documents FOR DELETE USING (is_manager());

-- TASK HISTORY POLICIES
-- Users can view history for tasks they're involved in
CREATE POLICY "task_history_select_involved" ON task_history FOR SELECT USING (
    user_id = auth.uid()
    OR task_id IN (
        SELECT id FROM housekeeping_tasks WHERE assigned_to = auth.uid() OR created_by = auth.uid()
        UNION
        SELECT id FROM maintenance_requests WHERE requested_by = auth.uid() OR assigned_to = auth.uid()
    )
);

-- Managers can view all task history
CREATE POLICY "task_history_select_managers" ON task_history FOR SELECT USING (is_manager());

-- Functions for common operations
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers to automatically update updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_rooms_updated_at BEFORE UPDATE ON rooms FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_housekeeping_tasks_updated_at BEFORE UPDATE ON housekeeping_tasks FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_maintenance_requests_updated_at BEFORE UPDATE ON maintenance_requests FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_announcements_updated_at BEFORE UPDATE ON announcements FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_documents_updated_at BEFORE UPDATE ON documents FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to log task status changes
CREATE OR REPLACE FUNCTION log_task_status_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        INSERT INTO task_history (task_type, task_id, user_id, action, old_status, new_status)
        VALUES (
            CASE WHEN TG_TABLE_NAME = 'housekeeping_tasks' THEN 'housekeeping' ELSE 'maintenance' END,
            NEW.id,
            COALESCE(NEW.assigned_to, NEW.created_by, NEW.requested_by),
            'status_changed',
            OLD.status,
            NEW.status
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers for task history logging
CREATE TRIGGER log_housekeeping_status_change AFTER UPDATE ON housekeeping_tasks FOR EACH ROW EXECUTE FUNCTION log_task_status_change();
CREATE TRIGGER log_maintenance_status_change AFTER UPDATE ON maintenance_requests FOR EACH ROW EXECUTE FUNCTION log_task_status_change();

-- Insert example data for 25 rooms
INSERT INTO rooms (room_number, floor, room_type, status, max_occupancy, amenities, notes) VALUES
('101', 1, 'standard', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker'], 'Ground floor, easy access'),
('102', 1, 'standard', 'occupied', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('103', 1, 'standard', 'dirty', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('104', 1, 'deluxe', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker', 'minibar'], 'Deluxe amenities'),
('105', 1, 'standard', 'maintenance', 2, ARRAY['wifi', 'tv', 'coffee_maker'], 'AC unit needs repair'),
('201', 2, 'standard', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('202', 2, 'standard', 'reserved', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('203', 2, 'suite', 'clean', 4, ARRAY['wifi', 'tv', 'coffee_maker', 'minibar', 'jacuzzi'], 'Family suite'),
('204', 2, 'standard', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('205', 2, 'deluxe', 'occupied', 2, ARRAY['wifi', 'tv', 'coffee_maker', 'minibar'], NULL),
('206', 2, 'standard', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('207', 2, 'standard', 'dirty', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('208', 2, 'executive', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker', 'minibar', 'workspace'], 'Business traveler room'),
('301', 3, 'standard', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('302', 3, 'standard', 'occupied', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('303', 3, 'deluxe', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker', 'minibar'], NULL),
('304', 3, 'standard', 'maintenance', 2, ARRAY['wifi', 'tv', 'coffee_maker'], 'Plumbing issue'),
('305', 3, 'suite', 'reserved', 4, ARRAY['wifi', 'tv', 'coffee_maker', 'minibar', 'jacuzzi'], NULL),
('306', 3, 'standard', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('307', 3, 'standard', 'dirty', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('308', 3, 'executive', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker', 'minibar', 'workspace'], NULL),
('309', 3, 'standard', 'out_of_order', 2, ARRAY['wifi', 'tv', 'coffee_maker'], 'Renovation in progress'),
('310', 3, 'deluxe', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker', 'minibar'], NULL),
('311', 3, 'standard', 'occupied', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL),
('312', 3, 'standard', 'clean', 2, ARRAY['wifi', 'tv', 'coffee_maker'], NULL);

-- Comments for documentation
COMMENT ON TABLE users IS 'Staff members with authentication and role information';
COMMENT ON TABLE rooms IS 'Hotel rooms with status, type, and amenities';
COMMENT ON TABLE housekeeping_tasks IS 'Cleaning and maintenance tasks for rooms';
COMMENT ON TABLE maintenance_requests IS 'Repair and maintenance requests';
COMMENT ON TABLE announcements IS 'Internal announcements and messages';
COMMENT ON TABLE documents IS 'Uploaded documents and files';
COMMENT ON TABLE task_history IS 'Audit trail for task status changes';
