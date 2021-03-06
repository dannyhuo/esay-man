<!DOCTYPE html>
<html>

<head>
    <#include "../template/meta.ftl" />
</head>

<body>
<!-- Sidenav -->
<#include "../template/menu.ftl" />

<!-- Main content -->
<div class="main-content" id="panel">
    <!-- Topnav -->
    <#include "../template/navigator.ftl" />
    <!-- Header -->
    <#--<#include "../template/header.ftl" />-->
    <!-- Header -->
    <div class="header bg-primary pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-lg-6 col-7">
                        <h6 class="h2 text-white d-inline-block mb-0">Node Manager</h6>
                        <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                            <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                                <li class="breadcrumb-item"><a href="#"><i class="fas fa-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="#">Nodes</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Nodes</li>
                            </ol>
                        </nav>
                    </div>
                    <div class="col-lg-6 col-5 text-right">
                        <a href="#" class="btn btn-sm btn-neutral" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Add Nodes</a>
                        <#assign title="Add new node">
                        <#include "node-form.ftl" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- The main content -->
    <div class="container-fluid mt--6">
        <!-- Table -->
        <div class="row">
            <div class="col">
                <div class="card">
                    <!-- Card header -->
                    <div class="card-header border-0">
                        <h3 class="mb-0">Node Lists</h3>
                    </div>
                    <!-- Light table -->
                    <div class="table-responsive" data-toggle="list" data-list-values='["nodeId", "nodeName", "hostName", "ip","ipPublic","status","comment","createTime","updateTime"]'>
                        <table class="table align-items-center table-flush">
                            <thead class="thead-light">
                            <tr>
                                <th scope="col" class="sort" data-sort="nodeId">Node ID</th>
                                <th scope="col" class="sort" data-sort="nodeName">Node Name</th>
                                <th scope="col" class="sort" data-sort="hostName">Host Name</th>
                                <th scope="col" class="sort" data-sort="ip">IP</th>
                                <th scope="col" class="sort" data-sort="ipPublic">IP Public</th>
                                <th scope="col" class="sort" data-sort="status">Status</th>
                                <th scope="col" class="sort" data-sort="comment">Comment</th>
                                <th scope="col" class="sort" data-sort="createTime">Create Time</th>
                                <th scope="col" class="sort" data-sort="updateTime">Update Time</th>
                                <th scope="col">action</th>
                            </tr>
                            </thead>
                            <tbody class="list">

                            <#list nodes as node>
                                <tr>
                                    <th scope="row">
                                        <div class="media align-items-center">
                                            <div class="media-body">
                                                <span class="nodeId mb-0 text-sm" data-toggle="tooltip" data-original-title="${node.nodeId!}">${node.nodeId?c}</span>
                                            </div>
                                        </div>
                                    </th>
                                    <td>
                                        <span class="badge badge-dot mr-4">
                                            <span class="nodeName" data-toggle="tooltip" data-original-title="${node.nodeName!}">${node.nodeName!}</span>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge badge-dot mr-4">
                                            <i class="bg-warning"></i>
                                            <span class="hostName" data-toggle="tooltip" data-original-title="${node.hostName!}">${node.hostName!}</span>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge badge-dot mr-4">
                                            <span class="ip" data-toggle="tooltip" data-original-title="${node.ip!}">${node.ip!}</span>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="badge badge-dot mr-4">
                                            <span class="ipPublic" data-toggle="tooltip" data-original-title="${node.ipPublic!}">${node.ipPublic!}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge badge-dot mr-4">
                                            <span class="status" data-toggle="tooltip" data-original-title="${node.status!}">${node.status!}</span>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge badge-dot mr-4">
                                            <span class="comment" data-toggle="tooltip" data-original-title="${node.comment!}">${node.comment!}</span>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge badge-dot mr-4">
                                            <i class="bg-inverse-warning"></i>
                                            <span class="createTime" data-toggle="tooltip" data-original-title="${node.createTime!}">${node.createTime!}</span>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge badge-dot mr-4">
                                            <span class="updateTime" data-toggle="tooltip" data-original-title="${node.updateTime!}">${node.updateTime!}</span>
                                        </span>
                                    </td>
                                    <td class="table-actions">
                                        <a href="#!" class="table-action" role="button" data-toggle="dropdown" aria-haspopup="true">
                                            <i class="fas fa-user-edit"></i>
                                        </a>
                                        <#assign node=node><#assign title="Edit node">
                                        <#include "node-form.ftl" />
                                        <a href="/nodes/delete?nodeId=${node.nodeId!?c}" class="table-action table-action-delete" aria-expanded="false"
                                           data-original-title="Delete node" onclick="deleteNode2(${node.nodeId!?c}, '${node.nodeName}')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </#list>
                            </tbody>
                        </table>
                    </div>
                    <!-- 分页 -->
                    <#include "../template/pager.ftl" />
                </div>
            </div>
        </div>

        <!-- Footer -->
        <#include "../template/footer.ftl" />

    </div>
</div>
<#include "../template/scripts.ftl" />

<script type="application/javascript" src="../static/myjs/nodemanager/node-list.js"></script>
</body>

</html>