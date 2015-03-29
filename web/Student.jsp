<%-- 
    Document   : student
    Created on : Mar 27, 2015, 4:46:29 PM
    Author     : spari_000
--%>

<%@page import="Session.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title id ="name"></title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='http://fonts.googleapis.com/css?family=Lobster' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Belgrano' rel='stylesheet' type='text/css'>
        <link href="css/mainStyles.css" rel="stylesheet" type="text/css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

        <script>
            function logout() {
                $.ajax({
                    url: '/TeamRocket/Logout',
                    type: 'GET',
                    success: function (data) {
                        alert(data);
                        window.open("index.html", "_self");

                    }
                });
            }

            $(document).ready(function () {
                $.ajax({
                    url: '/TeamRocket/tester',
                    type: 'GET',
                    dataType: 'text',
                    success: function (data) {
                        $("#namePlate").html("Hello" + " " + data);
                        $("#name").html(data);
                    }
                });
            });


        </script>
        <script>

            function registerButton_onclick() {
                window.open("RegistrationMain.html", "_self");
            }

        </script>

    </head>
    <body>
        <% if (((User) session.getAttribute("user")) == null || !((User) session.getAttribute("user")).getType().equals("s")) { %>
        <p> You Must Login! </p>
        <% } else {%>

        <div><h3 id="namePlate">Hello Student</h3></div>

        <div class="wrapper">
            <header>
                <div class="logo">
                    <h1><a href="">Rocket System</a></h1></div>


                <nav>
                    <ul id="navlist">
                        <li id="active"><a href="index.html">Home</a></li>
                        <li><a onclick="logout()" href="#">logout</a></li>
                        <li><a href="Register.html">Register</a></li>
                        <li><a href="#">Student</a></li>
                    </ul>
                </nav>
                <div class="clearfloat"></div>
            </header>
            <div class="bodyContainer">
                <section>
                    <div><img src="images/headerPic.jpg" alt=""></div>
                    <br />

                </section>


                <section>
                    <h2>About</h2>
                    <p>Rocket System is...</p>

                </section>
            </div>
            <div class="clearfloat"></div>
            <footer>
                <p>
                    Copyright &copy; Rocket System. All rights reserved. </p>
            </footer>
        </div>
        <% }%>
    </body>

</html>
