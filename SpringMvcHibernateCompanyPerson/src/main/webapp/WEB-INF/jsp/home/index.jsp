<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:layoutpage>
    <jsp:attribute name="title">Index</jsp:attribute>

    <jsp:body>
        <div class="container mt-5">

            <div class="card">
                <div class="card-header bg-white font-weight-bold">
                    <div class="d-flex justify-content-between">
                        Persons
                        <a href="home/create" class="btn btn-sm btn-success">Insert</a>
                    </div>
                </div>

                <div class="card-body">

                    <table class="table table-hover table-responsive-md">
                        <thead>
                        <tr>
                            <th scope="col">Id</th>
                            <th scope="col">Name</th>
                            <th scope="col">Surname</th>
                            <th scope="col">Email</th>
                            <th scope="col">Phone</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach var="person" items="${persons}">
                            <tr id="${person.id}">
                                <td>${person.id}</td>
                                <td>${person.firstname}</td>
                                <td>${person.lastname}</td>
                                <td>${person.email}</td>
                                <td class="d-flex justify-content-between align-items-center">${person.phoneNumber}
                                    <span>
                                        <button onclick="ajaxpost(${person.id})" class="btn btn-danger">Delete</button>
                                        <a href="home/update?id=${person.id}" class="btn btn-primary">Edit</a>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            function ajaxpost(id) {
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/delete",
                    data: {"id": id},
                    success: function (res) {
                        res = JSON.parse(res);
                        if (res.msg === "OK") {
                            $('#' + id).remove();
                        } else
                            alert("An error occurred during the operation.");
                    },
                    error: function (err) {
                        alert("Error! :\n" + err.message);
                    }
                });
            }
        </script>

    </jsp:body>

</t:layoutpage>