package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import repo.EnfantRepository;
import model.Enfant;
import repo.EnfantRepository;

@RestController
@RequestMapping("/api/v1/")
public class EnfantController {
	@Autowired
	private EnfantRepository enfantRepo;
	
	@GetMapping("Enfant")
	public List<Enfant> getAllEnfant(){
		return this.enfantRepo.findAll();
		
	}
	@GetMapping("children/{id}")
	public List<Enfant> {

}
