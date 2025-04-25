package ru.kpfu.itis.kulsidv.entity;

import jakarta.persistence.*;

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

    @ManyToOne
    @JoinColumn(name = "chapter_id")
    private Chapter chapter;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getPict() {
        return pict;
    }

    public void setPict(String pict) {
        this.pict = pict;
    }

    public Chapter getChapter() {
        return chapter;
    }

    public void setChapter(Chapter chapter) {
        this.chapter = chapter;
    }
}
