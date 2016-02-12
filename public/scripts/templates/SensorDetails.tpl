<div class="box-header no-border">
  <div id="sensorModuleListHeader" class="h3 box-title">Sensor Details: <%=id%></div>
  <div class="box-tools pull-right">

    <span class="label label-primary">Last Update: <%=updated.substring(11,19)%></span>
    <button data-widget="collapse" class="btn btn-box-tool">
      <i class="fa fa-minus"></i>
    </button>
    <button data-widget="remove" class="btn btn-box-tool">
      <i class="fa fa-times"></i>
    </button>
  </div>
</div>
<div class="box-body">
  <ul class="products-list product-list-in-box">
    <li class="item">
      <div class="product-img">
        <img src="https://cdn4.iconfinder.com/data/icons/whsr-january-flaticon-set/512/servers.png" alt="Product Image">
      </div>
      <div class="product-info">
        <a href="javascript::;" class="product-title">Sensor Location</a>
        <div id="sensorModuleListSensorLocation" class="span product-description">Lat: <%=lat%> | Lon: <%=lon%></div>
      </div>
    </li>
  </ul>
  <div class="table-responsive">
    <table class="table no-margin">
      <thead>
        <tr><th>Sensor Name</th><th>Value</th><th>Change</th></tr>
      </thead>
      <tbody>
        <% _.forEach(data, function(i) { %>
          <tr>
            <td><%=i.label%></td>
            <td><%=i.latest%></td>
            <td>
              <div data-color="#00a65a" data-height="20" class="sparkbar"><%=i.previous.join(',')%></div>
            </td>
          </tr>
        <% }); %>
      </tbody>
    </table>
  </div>
</div>