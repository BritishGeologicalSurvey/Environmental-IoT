<% _.each(nodes, function(sheep) {%>
  <li>
    <img src="<%=sheep.get('icon')%>" alt="Sheep Image"/>
    <a class="users-list-name">ID: <%=sheep.getAddress()%></a>
    <span class="users-list-data">Last Update: <span class="update-<%=sheep.getAddress()%>">Unknown</span></span>
  </li>
<%});%>
