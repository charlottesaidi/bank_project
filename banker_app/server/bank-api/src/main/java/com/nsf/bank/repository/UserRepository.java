package com.nsf.bank.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.nsf.bank.entity.User;
@Repository
public interface UserRepository  extends JpaRepository<User, Integer>{
	
	@Query("select u from User u where u.username = ?1") //JPQL : on travaille sur les classe et non les tables
	Optional<User> findUserWithName(String username);

	@Query("select u from User u where u.email = ?1")
	User findUserWithEmail(String email);

	@Query("select u from User u where u.username = ?1")
	User findUserWithHashId(String username);

}
