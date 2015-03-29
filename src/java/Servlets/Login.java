package Servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import Session.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author spari_000
 */
public class Login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String url = "/index.html";

        Connection con = null;
        Statement st = null;
        ResultSet rs = null;

        PrintWriter out = response.getWriter();
        /* TODO output your page here. You may use following sample code. */
        try {
            Class.forName("com.mysql.jdbc.Driver");
            java.util.Properties sysprops = System.getProperties();
            sysprops.put("user", "root");
            sysprops.put("password", "pass");

            //connect to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3310/rocketsystem", sysprops);
            st = con.createStatement();
            String query = "SELECT * FROM  user  WHERE email = \"" + email + "\" ;";
            rs = st.executeQuery(query);

            if (rs.next()) {
                String name = rs.getString("name");
                if (rs.getString("password").equals(password)) {
                    if (rs.getString("accountType").equals("s")) {
                        query = "SELECT * FROM  student  WHERE approved = 'y' and email = \"" + email + "\" ;";
                        rs = st.executeQuery(query);
                        System.out.println("student table query works");
                        if (rs.next() && rs.getString("approved").equals("y")) {
                            System.out.println("approved = yin student table");
                            url = "/Student.jsp";
                            User current = new User(name, email, password, "s");
                            HttpSession hg = request.getSession();
                            hg.setAttribute("user", current);

                        } else {
                            System.out.println("Approved = n in student table");
                            out.println("Account Waiting Approval");
                        }
                    } else if (rs.getString("accountType").equals("a")) {
                        url = "/Admin.jsp";
                        User current = new User(name, email, password, "a");
                        HttpSession hg = request.getSession();
                        hg.setAttribute("user", current);
                    }
                }
                System.out.println(url);
                RequestDispatcher dispatcher = request.getRequestDispatcher(url);
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            System.out.println(url);
            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
            dispatcher.forward(request, response);
            System.out.println(e.getMessage());
            System.out.println("error");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception ss) {
            }
            try {
                if (st != null) {
                    st.close();
                }
            } catch (Exception ss) {
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception ss) {
            }
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
