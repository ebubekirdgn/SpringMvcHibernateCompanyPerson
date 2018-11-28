package com.ebubekir.controllers;

import com.ebubekir.entities.Person;
import com.ebubekir.service.PersonManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class HomeController {

    private PersonManager personManager = new PersonManager();

    @RequestMapping(value = {"/", "/home", "/home/index"})
    public String index(Model model) {
        List<Person> persons = personManager.getList();
        model.addAttribute("persons", persons);
        return "home/index";
    }

    @RequestMapping(value = "home/create")
    public String create() {
        return "home/createorupdate";
    }

    @RequestMapping(value = "home/update", params = {"id"})
    public String update(@RequestParam(value = "id") int id, Model model) {
        model.addAttribute("person", personManager.get(id));
        return "home/createorupdate";
    }

    @PostMapping(value = "/createorupdate")
    public @ResponseBody
    String ajaxcreateorupdate(HttpServletRequest request) {

        Person person = new Person();
        person.setFirstname(request.getParameter("firstname"));
        person.setLastname(request.getParameter("lastname"));
        person.setEmail(request.getParameter("email"));
        person.setPhoneNumber(request.getParameter("phoneNumber"));

        String id = request.getParameter("id");
        System.out.println("id : " + id);

        String msg, method;
        if (id == null || id.isEmpty()) {
            msg = personManager.insert(person) ? "OK" : "ERROR";
            method = "CREATE";
        } else {
            person.setId(Integer.parseInt(id));
            msg = personManager.update(person) ? "OK" : "ERROR";
            method = "UPDATE";
        }
        return String.format("{\"msg\":\"%1s\", \"method\":\"%2s\"}", msg, method);
    }

    @PostMapping(value = "/delete")
    public @ResponseBody
    String ajaxpostdelete(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        String msg = personManager.delete(id) ? "OK" : "ERROR";
        return String.format("{\"msg\":\"%1s\"}", msg);
    }
}

