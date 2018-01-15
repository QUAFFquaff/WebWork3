package Test;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

/**
 * Created by 63263 on 2017/3/10.
 */
@WebServlet("/login")
public class Login extends HttpServlet {
    private HashMap<String, String> names =new HashMap<>();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean flag = true;
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if(username.toUpperCase().equals("SERVICE")||username.toUpperCase().equals("ADMIN")){
            request.getSession().setAttribute("username",username);
            response.sendRedirect("Service.jsp");
            flag = false;
        }else if(names.containsKey(username)){
            for(String str:names.keySet()){
                if(str.equals(username)){
                    if(names.get(str).equals(password)){
                        flag=true;
                        break;
                    }else {
                        flag = false;
                        response.sendRedirect("Login.jsp?error=yes");
                        System.out.println("error");
                        break;
                    }
                }
            }
        }else{
            names.put(username,password);
        }

        if(flag){
            request.getSession().setAttribute("username",username);
            response.sendRedirect("Test.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
