<%-- 
    Document   : view
    Created on : 7 nov. 2018, 13:25:16
    Author     : pedago
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Table des codes de promotion</title>
    </head>
    <body>
        <h1>Table des codes de promotion</h1>
        <form>
            <label for="code">
                Code: <input type="text" name="code" size="1" maxlength="1" 
                    title="Veuillez choisir une lettre, en majuscule ou minuscule"
                    pattern="[a-zA-Z]" required>
            </label>
            
            <label style="margin-left: 10px">
                Taux: <input name="taux" type="number" step="0.01" min="0.0" max="99.99" size="1" required>
            </label>
            <input type="hidden" name="action" value="ADD">
            <button type="submit" style="margin-left: 10px">Ajouter</button>
        </form>
        
        <div>
            <h4>${confirmationAction}</h4>
        </div>
        
        <div>
            <p></p>
            <table border="1">
                <th>Code</th><th>Taux</th><th>Action</th>
                <c:forEach var="ligne" items="${fullTable}">
                    <tr>
                        <td>${ligne.code}</td>
                        <td>${ligne.taux}</td>
                        <td>
                            <c:choose>
                                <c:when test="${usedCodes.contains(ligne.code)}">
                                    Utilisé
                                </c:when>
                                <c:otherwise>
                                    <a href="?action=DELETE&code=${ligne.code}" style="text-decoration:none">Supprimer?</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>                
            </table>
        </div>
    </body>
</html>
