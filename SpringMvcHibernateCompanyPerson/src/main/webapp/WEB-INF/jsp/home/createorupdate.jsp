<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date"/>

<c:choose>
    <c:when test="${empty person}">
        <c:set var="title" value="Insert"/>
    </c:when>
    <c:otherwise>
        <c:set var="title" value="Update"/>
    </c:otherwise>
</c:choose>

<t:layoutpage>
    <jsp:attribute name="title">${title}</jsp:attribute>

    <jsp:body>

        <div class="container mt-5">

            <form id="personForm">
                <input type="text" id="id" value="${person.id}" hidden>

                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label" for="firstname">Name</label>
                    <div class="col-lg-9">
                        <input class="form-control" type="text" id="firstname" name="firstname"
                               required value="${person.firstname}">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label" for="lastname">Surname</label>
                    <div class="col-lg-9">
                        <input class="form-control" type="text" id="lastname" name="lastname"
                               required value="${person.lastname}">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label" for="email">Email</label>
                    <div class="col-lg-9">
                        <input class="form-control" type="email" id="email" name="email"
                               required value="${person.email}">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-lg-3 col-form-label form-control-label" for="phoneNumber">Phone</label>
                    <div class="col-lg-9">
                        <input class="form-control" type="text" id="phoneNumber" name="phoneNumber" required
                               placeholder="xxx-xxx-xxxx" pattern='\d{3}-\d{3}-\d{4}' value="${person.phoneNumber}">
                    </div>
                </div>

                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">${title}</button>
                    <a href="/" class="btn btn-warning">Home Page</a>
                </div>

            </form>

        </div>
        <script>

            $(function () {
                $("#personForm").submit(function (e) {
                    e.preventDefault(e);

                    $.ajax({
                        type: "post",
                        url: "${pageContext.request.contextPath}/createorupdate",
                        data: {
                            "id": $('#id').val(),
                            "firstname": $('#firstname').val(),
                            "lastname": $('#lastname').val(),
                            "email": $('#email').val(),
                            "phoneNumber": $('#phoneNumber').val(),
                        },
                        success: function (res) {
                            res = JSON.parse(res);
                            if (res.msg === "OK") {
                                alert("The operation was performed successfully.");
                                if (res.method === "CREATE")
                                    resetData();
                            } else
                                alert("An error occurred during the operation.");
                        },
                        error: function (err) {
                            alert("Error! :\n" + err.message);
                        }
                    });
                });
            });

            function resetData() {
                $('#id').val('');
                $('#firstname').val('');
                $('#lastname').val('');
                $('#email').val('');
                $('#phoneNumber').val('');
            }
        </script>

    </jsp:body>

</t:layoutpage>