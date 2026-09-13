package com.zelo.chat.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(nullable = false, unique = true, length = 150)
    private String email;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Column(name = "birth_date", nullable = false)
    private LocalDate birthDate;

    @Column(name = "is_minor", nullable = false)
    private boolean minor;

    @ManyToOne
    @JoinColumn(name = "guardian_id")
    private User guardian;

    @Column(name = "public_key", columnDefinition = "TEXT")
    private String publicKey;

    @Enumerated(EnumType.STRING)
    @Column(name = "presence_status", nullable = false)
    private PresenceStatus presenceStatus = PresenceStatus.OFFLINE;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
}
