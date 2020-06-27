package com.mycompany.project.validator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mycompany.project.model.LoginForm;

@Component
public class LoginFormValidator implements Validator{

	private static final Logger LOGGER = LoggerFactory.getLogger(LoginFormValidator.class);
	
	@Override
	public boolean supports(Class<?> clazz) {
		LOGGER.info("실행");
		return LoginForm.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		LOGGER.info("실행");
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mid", "", "아이디를 입력하세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mpassword", "", "비밀번호를 입력하세요.");
	}
	
}
