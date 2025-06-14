package ru.kpfu.itis.kulsidv.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.kulsidv.entity.Chapter;
import ru.kpfu.itis.kulsidv.entity.Progress;
import ru.kpfu.itis.kulsidv.entity.User;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProgressRepository extends JpaRepository<Progress, Integer> {
    List<Progress> findAllByUserId(Integer id);
    Optional<Progress> findByUserAndChapter(User user, Chapter chapter);
}
