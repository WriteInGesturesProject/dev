package com.example.demo.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.model.Enfant;

@Repository
public interface EnfantRepository extends JpaRepository<Enfant, Long>{

}
