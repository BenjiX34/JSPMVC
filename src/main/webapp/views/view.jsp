<%-- 
    Document   : view
    Created on : 7 nov. 2018, 13:25:16
    Author     : pedago
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Page de gestion des codes de promotion</title>
        <style>
            body{background-color: #eee;}
            a{text-decoration: none; color: #ff5555;}
            fieldset {display:inline; padding: 10px;}
            fieldset > * {margin: 10px;}
            table{background-color: white;}
        </style>
    </head>
    <body>
        <h2>Page de gestion des codes de promotion</h2>
        <form>
            <fieldset>
                <legend>Ajout d'un code de promotion</legend>
                <label>
                    Code: <input type="text" name="code" size="1" maxlength="1" 
                        title="Veuillez choisir une lettre, en majuscule ou minuscule"
                        pattern="[a-zA-Z]" required>
                </label>

                <label>
                    Taux: <input name="taux" type="number" step="0.01" min="0.0" max="99.99" size="5" required>
                </label>
                <input type="hidden" name="action" value="ADD">
                <button type="submit">Ajouter</button>
            </fieldset>
        </form>

        <form>
            <fieldset>
                <legend>Modification d'un code existant</legend>
                <label>
                    Code:
                    <select name="code">
                        <c:forEach var="ligne" items="${fullTable}">
                            <option value="${ligne.code}">${ligne.code}</option>
                        </c:forEach>
                    </select>
                </label>
                <label>
                    Taux: <input name="taux" type="number" step="0.01" min="0.0" max="99.99" size="5" required>
                </label>
                <input type="hidden" name="action" value="MODIFY">
                <button type="submit">Modifier</button>
            </fieldset>
        </form>
            
        <div>
            <h4>${confirmationAction}</h4>
        </div>
        
        <div>
            <p></p>
            <table border="1" cellpadding="10">
                <tr>
                    <th colspan="3">Table des codes</th>
                </tr>
                
                <tr>
                    <th>Code</th><th>Taux</th>
                </tr>
                
                <c:forEach var="ligne" items="${fullTable}">
                    <tr>
                        <td>${ligne.code}</td>
                        <td><fmt:formatNumber type="number" pattern="00.00" value="${ligne.taux}" /> %</td>
                        <td>
                            <c:choose>
                                <c:when test="${usedCodes.contains(ligne.code)}">
                                    Utilisé
                                </c:when>
                                <c:otherwise>
                                    <a href="?action=DELETE&code=${ligne.code}">Supprimer</a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>                
            </table>
        </div>
    </body>
</html>
