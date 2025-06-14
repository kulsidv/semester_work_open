package ru.kpfu.itis.kulsidv.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "paragraphs")
public class Paragraph {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "text", length = 1000)
    private String text;

    @Column(name = "pict")
    private String pict;

    @Column(name = "order_num")
    private Integer orderNum;

    @ManyToOne
    @JoinColumn(name = "chapter_id")
    private Chapter chapter;
}
