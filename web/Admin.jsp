
<%@page import="Session.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--
Design by Free Responsive Templates
http://www.free-responsive-templates.com
Released for free under a Creative Commons Attribution 3.0 Unported License (CC BY 3.0) 
-->
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title id ="name"></title>
        <link href='http://fonts.googleapis.com/css?family=Lobster' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Belgrano' rel='stylesheet' type='text/css'>
        <link href="css/mainStyles.css" rel="stylesheet" type="text/css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            function addSchoolButton_onclick() {
                window.open("AddSchool.html", "_self");
            }
        </script>

        <script>

            $(document).ready(function () {
                $.ajax({
                    url: '/TeamRocket/tester',
                    type: 'GET',
                    dataType: 'text',
                    success: function (data) {
                        $("#namePlate").html("Admin - " + data);
                        $("#name").html("User " + data);
                    }
                });
            });


        </script>
        <script language="javascript" type="text/javascript">

            window.onload = function () {

                $.ajax({
                    url: '/TeamRocket/DisplayAllPendingStudentAccountRequests',
                    type: 'GET',
                    dataType: 'JSON',
                    success: function (data)
                    {
                        $("#studentList").html("");
                        for (var i = 0; i < data.length; i++) {
                            $("#studentList").append("<p>Name: " + data[i].name + " - - - - Email: "
                                    + data[i].email + "<input type='checkbox' class='emails' " + "value='" + data[i].email + "'></p>");
                        }
                    }
                });
            }

            function ApproveAll() {
                $.ajax({
                    url: '/TeamRocket/ApproveAllPendingStudentAccountRequests',
                    type: 'GET',
                    dataType: 'JSON',
                    success: function (data)
                    {
                        $("#studentList").html("");
                        $("#studentList").append("The following accounts have been approved:");
                        for (var i = 0; i < data.length; i++) {
                            $("#studentList").append("<br><p>Email: " + data[i].email + "</p><p>Name: " + data[i].name);
                        }
                    }
                });
            }

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

            function ApproveSelected() {
                var e = "";
                $('input:checkbox.emails').each(function () {

                    if (this.checked && this.value !== "") {

                        e = this.value + "?" + e;
                    }
                });

                $.ajax({
                    url: '/TeamRocket/ApprovePendingStudentAccountRequests',
                    type: 'GET',
                    data: {emails: e},
                    dataType: 'JSON',
                    success: function (data) {
                        $("#studentList").html("");
                        $("#studentList").append("The following accounts have been approved: \n");
                        for (var i = 0; i < data.length; i++) {
                            $("#studentList").append("<br><p>Email: " + data[i].email + "</p><p>Name: " + data[i].name);
                        }

                    }
                });
            }
        </script>
    </head>
    <body>
        <% if (((User) session.getAttribute("user")) == null || !((User) session.getAttribute("user")).getType().equals("a")) { %>
        <p> You Must Login as an Admin to View This Page! </p>
        <% } else {%>

        <div><h3 id="namePlate">Hello Admin</h3></div>

        <div class="wrapper">
            <header>
                <div class="logo"><h1><a href="">Corn Food</a></h1></div>
                <nav>
                    <ul id="navlist">
                        <li id="active"><a href="index.html">Home</a></li>
                        <li><a onclick="logout()" href="#">logout</a></li>
                        <li><a href="Register.html">Register</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </nav>
                <div class="clearfloat"></div>
            </header>
            <div class="bodyContainer">

                <!-- section 0 -->

                <section>
                    <div><img src="images/headerPic.jpg" alt=""></div>
                    <input id = "approveAllStudentRequestButton" style = "font-weight: bold; font-size: 16pt;width:" type = "button" value = "Approve All Pending Requests"  onclick = "ApproveAll()" />
                    &nbsp;
                    <input  id = "deleteSchoolButton" style = "font-weight: bold; font-size: 16pt;width:" type = "button" value = "Delete Student Account"  onclick = "" /> 
                </section>
                <!-- section 1 -->
                <section>
                    <div class>
                        <br/> 
                        <input id = "approveButton" style = "font-weight: bold; font-size: 16pt;width:" type = "button" value = "Approve"  onclick = "ApproveSelected()" />
                        &nbsp;
                        <input  id = "deleteStduentAccount" style = "font-weight: bold; font-size: 16pt;width:" type = "button" value = "Delete a pending student list"  onclick = "" /> 
                        <br/> 

                    </div>  
                </section>

                <!-- section 2-->
                <section>
                    <div class>
                        <div id="studentListDiv">
                            <h3>Pending Student Account Requests</h3>
                            <div id="studentList" style="float:left; width:100%; min-height: 200px"></div>
                        </div>

                        <input id = "addSchoolButton" style = "font-weight: bold; font-size: 16pt;width:" type = "button" value = "Add School"  onclick = "addSchoolButton_onclick()" />
                        <input  id = "deleteStudentAccountButton" style = "font-weight: bold; font-size: 16pt;width:" type = "button" value = "Delete School"  onclick = "" /> 
                    </div>  
                </section>    


                <!-- section 3 -->

                <section>



                </section>



                <!-- section 4 -->
                <section>

                </section>

                <section>
                    <h2>About</h2>
                    <p>
                        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, 
                    </p>
                    <p class="readMore"><a href="">{ Read More! }</a></p>
                </section>
            </div>
            <div class="clearfloat"></div>
            <footer>
                <p>
                    Copyright &copy; Your Company Name. All rights reserved. Designed by <a href="http://www.free-responsive-templates.com" title="free responsive templates">Free Responsive Templates</a>, Validation 
                    <a class="footerLink" href="http://validator.w3.org/check/referer" title="This page validates as HTML5"><abbr title="HyperText Markup Language">HTML5</abbr></a> | 
                    <a class="footerLink" href="http://jigsaw.w3.org/css-validator/check/referer" title="This page validates as CSS"><abbr title="Cascading Style Sheets">CSS3</abbr></a>
                </p>
            </footer>
        </div>
        <% }%>
    </body>

</html>


