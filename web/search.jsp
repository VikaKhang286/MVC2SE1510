<%-- 
    Document   : search
    Created on : Jun 7, 2021, 12:47:02 PM
    Author     : Loc
--%>

<%@page import="khangvv.registration.RegistrationDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search</title>
    </head>
    <body>
        <%
            Cookie[] cookies = request.getCookies();
            if(cookies != null){
                %> 
                <font color="red">Welcome, <%= cookies[cookies.length - 1].getName() %> </font>
        <%
            }//end cookies are existed
        %>
        <h1>Search Page</h1>
        <form action="DispatchController">
            Search Value <input type="text" name="txtSearchValue" 
                                value="<%= request.getParameter("txtSearchValue")%>" /><br/>
            <input type="submit" value="Search" name="btAction" />
        </form><br/>
        
        <% 
            String searchValue = request.getParameter("txtSearchValue");
            if(searchValue != null){
                List<RegistrationDTO> result = 
                        (List<RegistrationDTO>)request.getAttribute("SEARCH_RESULT");
                if (result != null) {
                    %>
                    <table border="1">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Username</th>
                                <th>Password</th>
                                <th>Full name</th>
                                <th>Role</th>
                                <th>Delete</th>
                                <th>Update</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                int count = 0;
                                for (RegistrationDTO dto: result){
                                    String urlRewriting = "DispatchController"
                                                            + "?btAction=delete"
                                                            + "&usename=" + dto.getUsername()
                                                            + "&lastSearchValue=" + searchValue;
                                    %>                                                       
                        <form action="DispatchController">        
                                    <tr>
                                    <td>
                                        <%= ++count %>
                                    </td>
                                    <td>
                                        <%= dto.getUsername() %>
                                        <input type="text" name="txtUsername" 
                                               value="<%= dto.getUsername() %>" />
                                    </td>
                                    <td>                       
                                        <input type="text" name="txtPassword" 
                                               value="<%= dto.getPassword() %>" />
                                    </td>
                                    <td>
                                        <%= dto.getLastname() %>
                                    </td>
                                    <td>
                                        <input type="checkbox" name="chkAdmin" value="ON"
                                            <% 
                                            if (dto.isRole()) {
                                                %>
                                                checked = "checked"
                                            <%
                                            }//end admin role is true
                                            %>
                                            />
                                    </td>
                                    <td>
                                        <a href="<%= urlRewriting %>">Delete</a>
                                    </td>
                                    <td>
                                        <input type="submit" value="Update" name="btAction" />
                                        <input type="hidden" name="lastSearchValue" 
                                               value="<%= searchValue %>" />
                                    </td>
                                </tr>
                        </form>        
                            <%
                                }//end for dto in result
                            %>
                        </tbody>
                    </table>

        <%
                } else {
                    %> 
                    <h2>
                        No record is matched!!!
                    </h2>
        <%
                }
            }//end if search Value has valid
        %>
    </body>
</html>
