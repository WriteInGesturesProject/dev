package repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Enfant;

@Repository
public interface EnfantRepository extends JpaRepository<Enfant, Long>{

}
