package ru.kpfu.itis.kulsidv.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.kulsidv.entity.Paragraph;

import java.util.List;

@Repository
public interface ParagraphRepository extends JpaRepository<Paragraph, Integer> {
    List<Paragraph> findAllByChapterId(Integer id);
}
