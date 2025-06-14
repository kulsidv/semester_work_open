package ru.kpfu.itis.kulsidv.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.kulsidv.entity.Chapter;

@Repository
public interface ChapterRepository extends JpaRepository<Chapter, Integer> {
}
