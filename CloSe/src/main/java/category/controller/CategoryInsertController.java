package category.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CategoryInsertController {
	
	private final String command = "/insert.category";
	private final String viewPage = "categoryInsertForm";
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String insertForm() {
		
		return viewPage;
	}
}
