CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    is_minor BOOLEAN NOT NULL DEFAULT FALSE,
    guardian_id BIGINT NULL,
    public_key TEXT NULL,
    presence_status VARCHAR(20) NOT NULL DEFAULT 'OFFLINE',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_guardian FOREIGN KEY (guardian_id) REFERENCES users(id)
);

CREATE TABLE contacts (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    contact_id BIGINT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_contact_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_contact_contact FOREIGN KEY (contact_id) REFERENCES users(id),
    CONSTRAINT uk_contact UNIQUE (user_id, contact_id)
);

CREATE TABLE conversations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(20) NOT NULL DEFAULT 'INDIVIDUAL',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE conversation_participants (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    conversation_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    CONSTRAINT fk_participant_conversation FOREIGN KEY (conversation_id) REFERENCES conversations(id),
    CONSTRAINT fk_participant_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT uk_participant UNIQUE (conversation_id, user_id)
);

CREATE TABLE messages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    conversation_id BIGINT NOT NULL,
    sender_id BIGINT NOT NULL,
    encrypted_content TEXT NOT NULL,
    iv VARCHAR(255) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'SENT',
    sent_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_message_conversation FOREIGN KEY (conversation_id) REFERENCES conversations(id),
    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) REFERENCES users(id)
);

CREATE TABLE lgpd_consents (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    type VARCHAR(50) NOT NULL,
    term_version VARCHAR(20) NOT NULL,
    accepted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_consent_user FOREIGN KEY (user_id) REFERENCES users(id)
);