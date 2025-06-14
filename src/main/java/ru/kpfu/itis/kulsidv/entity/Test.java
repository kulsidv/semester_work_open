package ru.kpfu.itis.kulsidv.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@ToString
@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "tests")
public class Test {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "question", nullable = false, length = 250)
    private String question;

    @Column(name = "answer", nullable = false, length = 100)
    private String answer;

    @ManyToOne()
    @JoinColumn(name = "chapter_id")
    private Chapter chapter;

    @ElementCollection()
    @CollectionTable(
            name = "test_variants",
            joinColumns = @JoinColumn(name = "test_id")
    )
    @Column(name = "variant")
    private List<String> vars = new ArrayList<>();
}
