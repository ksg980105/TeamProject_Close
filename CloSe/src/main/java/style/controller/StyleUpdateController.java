package style.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import style.model.StyleBean;
import style.model.StyleDao;

@Controller
public class StyleUpdateController {

	private final String command = "update.style";
	private final String viewPage = "styleUpdateForm";
	private final String gotoPage = "redirect:/mainView.style";

	@Autowired
	ServletContext servletContext;

	@Autowired
	private StyleDao styleDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String updateForm(@RequestParam("style_number") int style_number, Model model) {
		model.addAttribute("styleBean", styleDao.getStyleByStyleNumber(style_number));
		return viewPage;
	}

	@RequestMapping(value = command, method = RequestMethod.POST)
	public String update(StyleBean styleBean) {

		String path = servletContext.getRealPath("/resources/styleImage");

		File directory = new File(path);
		if (!directory.exists()) {
			directory.mkdirs();
		}
		
		System.out.println(styleBean.getPrevImage1());
		System.out.println(styleBean.getPrevImage2());
		System.out.println(styleBean.getPrevImage3());
		System.out.println(styleBean.getPrevImage4());
		System.out.println(styleBean.getPrevImage5());
		
		if (styleBean.getPrevImage1().equals("") && styleBean.getPrevImage2().equals("") && styleBean.getPrevImage3().equals("")
				&& styleBean.getPrevImage4().equals("") && styleBean.getPrevImage5().equals("")) {
			List<MultipartFile> images = styleBean.getImages();
			for (int i = 1; i < images.size() + 1; i++) {
				String imageName = null;
				MultipartFile image = null;
				switch (i) {
				case 1:
					imageName = styleBean.getImage1();
					image = styleBean.getMImage1();
					break;
				case 2:
					imageName = styleBean.getImage2();
					image = styleBean.getMImage2();
					break;
				case 3:
					imageName = styleBean.getImage3();
					image = styleBean.getMImage3();
					break;
				case 4:
					imageName = styleBean.getImage4();
					image = styleBean.getMImage4();
					break;
				case 5:
					imageName = styleBean.getImage5();
					image = styleBean.getMImage5();
					break;
				default:
					break;
				}

				File uploadImage = new File(path + File.separator + imageName);
				try {
					image.transferTo(uploadImage);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			for(int i=1; i<6; i++) {
				String compareImage = null;
				switch (i) {
				case 1:
					compareImage = styleBean.getCompareImage1();
					break;
				case 2:
					compareImage = styleBean.getCompareImage2();
					break;
				case 3:
					compareImage = styleBean.getCompareImage3();
					break;
				case 4:
					compareImage = styleBean.getCompareImage4();
					break;
				case 5:
					compareImage = styleBean.getCompareImage5();
					break;
				default:
					break;
				}
				File deleteImage = new File(path + File.separator + compareImage);
				deleteImage.delete();
			}
			System.out.println("사진 있"+styleBean.getPrevImage1());
			styleDao.updateStyle(styleBean);
		} else {
			System.out.println("사진 없"+styleBean.getPrevImage1());
			styleDao.updateStyleNoImageUp(styleBean);
		}

		
		return gotoPage;
	}

}