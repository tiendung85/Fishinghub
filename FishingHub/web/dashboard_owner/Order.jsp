<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.Users" %>

<%
    Users currentUser = (Users) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#4f46e5',
                        secondary: '#10b981'
                    },
                    borderRadius: {
                        'none': '0px',
                        'sm': '4px',
                        DEFAULT: '8px',
                        'md': '12px',
                        'lg': '16px',
                        'xl': '20px',
                        '2xl': '24px',
                        '3xl': '32px',
                        'full': '9999px',
                        'button': '8px'
                    }
                }
            }
        };
    </script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
        }

        .sidebar-item.active {
            background-color: rgba(79, 70, 229, 0.1);
            color: #4f46e5;
            border-left: 3px solid #4f46e5;
        }

        .custom-scrollbar::-webkit-scrollbar {
            width: 5px;
        }

        .custom-scrollbar::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #d1d5db;
            border-radius: 8px;
        }

        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
            background: #9ca3af;
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .status-dropdown {
            display: none;
            position: absolute;
            right: 0;
            top: 100%;
            z-index: 10;
        }

        .status-action:hover .status-dropdown {
            display: block;
        }
    </style>
</head>

<body>
    <div class="flex h-screen overflow-hidden">
        <!-- Sidebar -->
        <div class="hidden md:flex md:flex-shrink-0">
            <div class="flex flex-col w-64 bg-white border-r border-gray-200">
                <div class="flex items-center justify-center h-16 px-4 border-b border-gray-200">
                    <h1 class="text-2xl font-['Pacifico'] text-primary">logo</h1>
                </div>
                <div class="flex flex-col flex-grow px-2 py-4 overflow-y-auto custom-scrollbar">
                    <div class="space-y-1">
                        <div class="px-2 py-2 text-xs font-semibold text-gray-500 uppercase">
                            Tổng quan
                        </div>
                        <a href="OwnerDashboard"
                            class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                <i class="ri-dashboard-line"></i>
                            </div>
                            Dashboard
                        </a>


                        <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">
                            Quản lý sự kiện
                        </div>
                        <a href="#"
                            class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                <i class="ri-calendar-event-line"></i>
                            </div>
                            Sự kiện
                        </a>


                        <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">
                            Quản lý sản phẩm
                        </div>
                        <a href="#"
                            class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                <i class="ri-shopping-bag-line"></i>
                            </div>
                            Danh sách sản phẩm
                        </a>
                        <a href="Order"
                            class="sidebar-item active flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                <i class="ri-shopping-cart-line"></i>
                            </div>
                            Đơn hàng
                        </a>

                    </div>
                </div>
                <div class="flex items-center p-4 border-t border-gray-200">
                    <div class="flex-shrink-0">
                        <img class="w-10 h-10 rounded-full"
                            src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20male%20administrator%20with%20short%20black%20hair%2C%20wearing%20a%20business%20casual%20outfit%2C%20looking%20confident%20and%20friendly%2C%20high%20quality%2C%20realistic%2C%20studio%20lighting&width=100&height=100&seq=admin123&orientation=squarish"
                            alt="Admin" />
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-gray-700">
                            <%= currentUser != null ? currentUser.getFullName() : "Khách" %>
                        </p>
                        <p class="text-xs font-medium text-gray-500">
                            <% if(currentUser != null && currentUser.getRoleId() == 2) { %>
                            Chủ Hồ Câu
                            <% } else { %>
                            Quản trị viên
                            <% } %>
                        </p>
                    </div>
                </div>
                <!-- Nút quay lại Home -->
                <div class="p-4">
                    <a href="Home.jsp" class="flex items-center justify-center w-full bg-primary text-white py-2 rounded-button font-medium hover:bg-primary/90 transition">
                        <i class="ri-arrow-left-line mr-2"></i> Quay lại Trang Chủ
                    </a>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="flex flex-col flex-1 w-0 overflow-hidden">
            <!-- Top navigation -->
            <div class="relative z-10 flex-shrink-0 flex h-16 bg-white border-b border-gray-200">
                <button type="button" class="px-4 border-r border-gray-200 text-gray-500 md:hidden">
                    <div class="w-6 h-6 flex items-center justify-center">
                        <i class="ri-menu-line"></i>
                    </div>
                </button>
                <div class="flex-1 px-4 flex justify-between">
                    <div class="flex-1 flex items-center">
                        <div class="w-full max-w-2xl">
                            <div class="text-lg font-semibold text-gray-800">
                                Xin Chào Chủ Hồ Câu
                            </div>
                        </div>
                    </div>
                    <div class="ml-4 flex items-center md:ml-6">
                        <button
                            class="p-1 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none">
                            <div class="w-6 h-6 flex items-center justify-center">
                                <i class="ri-notification-3-line"></i>
                            </div>
                        </button>
                        <div class="relative ml-3">
                            <div class="flex items-center">
                                <span
                                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                    Online
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main content area -->
            <main class="flex-1 relative overflow-y-auto focus:outline-none custom-scrollbar">
                <div class="py-6">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                        <div class="flex items-center justify-between mb-6">
                            <h1 class="text-2xl font-semibold text-gray-900">Quản lý đơn hàng</h1>
                            <div class="flex space-x-3">
                                <span class="text-sm text-gray-500">21/05/2025</span>
                                <span class="text-sm text-gray-500">|</span>
                                <span class="text-sm text-gray-500">Wednesday</span>
                            </div>
                        </div>
                    </div>

                    <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                        <!-- Filter section -->
                        <div class="bg-white p-4 rounded-lg shadow mb-6">
                            <div
                                class="flex flex-col md:flex-row md:items-center md:justify-between space-y-4 md:space-y-0 md:space-x-4">
                                <div
                                    class="flex flex-col sm:flex-row sm:items-center space-y-4 sm:space-y-0 sm:space-x-4">
                                    <div class="relative inline-block w-full sm:w-52">
                                        <div class="flex">
                                            <div
                                                class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <div
                                                    class="w-5 h-5 flex items-center justify-center text-gray-400">
                                                    <i class="ri-filter-line"></i>
                                                </div>
                                            </div>
                                            <select id="status-filter"
                                                class="block w-full pl-10 pr-10 py-2 text-base border border-gray-200 rounded-md focus:outline-none focus:ring-1 focus:ring-primary focus:border-primary sm:text-sm">
                                                <option value="">Tất cả trạng thái</option>
                                                <c:forEach var="status" items="${statuses}">
                                                    <option value="${status.statusID}">${status.statusName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <div
                                                class="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
                                                <div
                                                    class="w-5 h-5 flex items-center justify-center text-gray-400">
                                                    <i class="ri-arrow-down-s-line"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="flex items-center space-x-4">
                                    <div class="relative w-full sm:w-64">
                                        <div
                                            class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                            <div
                                                class="w-5 h-5 flex items-center justify-center text-gray-400">
                                                <i class="ri-search-line"></i>
                                            </div>
                                        </div>
                                        <input type="text" id="order-search"
                                            class="block w-full pl-10 pr-3 py-2 border border-gray-200 rounded-md text-sm placeholder-gray-500 focus:outline-none focus:ring-1 focus:ring-primary focus:border-primary"
                                            placeholder="Tìm theo mã đơn hoặc khách hàng">
                                    </div>
                                    <button id="reset-filter"
                                        class="inline-flex items-center px-3 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none !rounded-button whitespace-nowrap">
                                        <div class="w-4 h-4 mr-1 flex items-center justify-center">
                                            <i class="ri-refresh-line"></i>
                                        </div>
                                        Làm mới
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Orders table -->
                        <div class="bg-white shadow rounded-lg overflow-hidden">
                            <div class="px-5 py-4 border-b border-gray-200">
                                <div class="flex items-center justify-between">
                                    <h2 class="text-lg font-medium text-gray-900">Danh sách đơn hàng</h2>
                                    <div class="flex items-center space-x-2">
                                        <span class="text-sm text-gray-500">Tổng: <c:out value="${totalOrders}"/> đơn hàng</span>
                                    </div>
                                </div>
                            </div>
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Mã đơn hàng
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Khách hàng
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Ngày đặt
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Tạm tính
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Tổng tiền
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Trạng thái
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Thao tác
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200" id="orders-tbody">
                                        <c:forEach var="order" items="${orders}">
                                            <tr class="hover:bg-gray-50 cursor-pointer"
                                                data-status="${order.status.statusID}"
                                                data-order-id="${order.id}"
                                                data-status-id="${order.status.statusID}">
                                                <td
                                                    class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                    #ORD-${order.id}
                                                </td>
                                                <td
                                                    class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    ${order.customerName}
                                                </td>
                                                <td
                                                    class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <fmt:formatDate value="${order.orderDate}"
                                                        pattern="dd/MM/yyyy HH:mm" />
                                                </td>
                                                <td
                                                    class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <fmt:formatNumber value="${order.subtotal}"
                                                        type="number" groupingUsed="true" /> ₫
                                                </td>
                                                <td
                                                    class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                    <fmt:formatNumber value="${order.total}" type="number"
                                                        groupingUsed="true" /> ₫
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                        <c:choose>
                                                            <c:when test="
                                                        ${order.status.statusID==4}">bg-purple-100
                                                        text-purple-800</c:when>
                                                        <c:when test="${order.status.statusID == 2}">
                                                            bg-blue-100 text-blue-800</c:when>
                                                        <c:when test="${order.status.statusID == 1}">
                                                            bg-yellow-100 text-yellow-800</c:when>
                                                        <c:when test="${order.status.statusID == 3}">
                                                            bg-green-100 text-green-800</c:when>
                                                        <c:when test="${order.status.statusID == 5}">
                                                            bg-red-100 text-red-800</c:when>
                                                        <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                                                        </c:choose>">
                                                        ${order.status.statusName}
                                                    </span>
                                                </td>
                                                <td
                                                    class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                    <div class="flex justify-end space-x-2">
                                                        <button class="text-primary hover:text-indigo-900">Xem</button>
                                                        <c:choose>
                                                            <c:when test="${order.status.statusID == 3 || order.status.statusID == 5}">
                                                                <button class="text-gray-400 cursor-not-allowed" disabled>Trạng thái</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="dropdown relative">
                                                                    <button class="text-gray-600 hover:text-gray-900 dropdown-toggle">Trạng thái</button>
                                                                    <ul class="dropdown-menu absolute right-0 mt-2 min-w-[160px] bg-white shadow-lg rounded-md border border-gray-200 py-1 z-10" style="display:none;">
                                                                        <c:forEach var="status" items="${statuses}">
                                                                            <li>
                                                                                <a href="javascript:void(0)" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                                                                   onclick="confirmStatusChange(<c:out value='${status.statusID}'/>, <c:out value='${order.id}'/>, '<c:out value='${status.statusName}'/>')">
                                                                                <c:out value='${status.statusName}'/>
                                                                            </a>
                                                                        </li>
                                                                        </c:forEach>
                                                                    </ul>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination -->
                            <div
                                class="px-5 py-4 border-t border-gray-200 flex items-center justify-between pagination-section">
                                <div class="flex-1 flex justify-between sm:hidden">
                                    <button
                                        class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 !rounded-button whitespace-nowrap">
                                        Trước
                                    </button>
                                    <button
                                        class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 !rounded-button whitespace-nowrap">
                                        Sau
                                    </button>
                                </div>
                                <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                                    <div>
                                        <p class="text-sm text-gray-700">
                                            Hiển thị <span class="font-medium"><c:out value="${startOrder}"/></span> đến <span
                                                class="font-medium"><c:out value="${endOrder}"/></span> của <span
                                                class="font-medium"><c:out value="${totalOrders}"/></span> kết quả
                                        </p>
                                    </div>
                                    <div>
                                        <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px"
                                            aria-label="Pagination">
                                            <c:choose>
                                                <c:when test="${currentPage > 1}">
                                                    <a href="Order?page=${currentPage - 1}"
                                                       class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                        <span class="sr-only">Trang trước</span>
                                                        <div class="w-5 h-5 flex items-center justify-center">
                                                            <i class="ri-arrow-left-s-line"></i>
                                                        </div>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-gray-100 text-sm font-medium text-gray-300 cursor-not-allowed">
                                                        <span class="sr-only">Trang trước</span>
                                                        <div class="w-5 h-5 flex items-center justify-center">
                                                            <i class="ri-arrow-left-s-line"></i>
                                                        </div>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <c:choose>
                                                    <c:when test="${i == currentPage}">
                                                        <span aria-current="page"
                                                              class="z-10 bg-primary border-primary text-white relative inline-flex items-center px-4 py-2 border text-sm font-medium">${i}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="Order?page=${i}"
                                                           class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">${i}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${currentPage < totalPages}">
                                                    <a href="Order?page=${currentPage + 1}"
                                                       class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                        <span class="sr-only">Trang sau</span>
                                                        <div class="w-5 h-5 flex items-center justify-center">
                                                            <i class="ri-arrow-right-s-line"></i>
                                                        </div>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-gray-100 text-sm font-medium text-gray-300 cursor-not-allowed">
                                                        <span class="sr-only">Trang sau</span>
                                                        <div class="w-5 h-5 flex items-center justify-center">
                                                            <i class="ri-arrow-right-s-line"></i>
                                                        </div>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            // Dropdown trạng thái: click mới xổ, click ngoài thì ẩn
            $(document).on('click', '.dropdown-toggle', function (e) {
                e.stopPropagation();
                // Ẩn tất cả menu khác trước khi xổ
                $('.dropdown-menu').hide();
                $(this).siblings('.dropdown-menu').toggle();
            });
            // Click ngoài dropdown thì ẩn menu
            $(document).on('click', function () {
                $('.dropdown-menu').hide();
            });
            // Ngăn click trong menu làm ẩn menu
            $(document).on('click', '.dropdown-menu', function (e) {
                e.stopPropagation();
            });

            function filterOrdersServer() {
                var selectedStatus = $('#status-filter').val();
                var keyword = $('#order-search').val();
                // Nếu không lọc, không tìm kiếm thì reload lại trang để phân trang lại
                if ((selectedStatus === '' || selectedStatus == null) && (!keyword || keyword.trim() === '')) {
                    window.location.reload();
                    return;
                }
                $.ajax({
                    url: 'Order',
                    type: 'GET',
                    data: {
                        status: selectedStatus,
                        keyword: keyword
                    },
                    success: function (data) {
                        var parts = data.split('<!--SPLIT--->');
                        $('#orders-tbody').html(parts[0]);
                        $('#totalOrders').text(parts[1]);
                        // Ẩn phân trang
                        $('.pagination-section').hide();
                    }
                });
            }
            $('#status-filter').on('change', filterOrdersServer);
            $('#order-search').on('input', filterOrdersServer);
            // Làm mới bộ lọc và tìm kiếm
            $('#reset-filter').on('click', function () {
                $('#status-filter').val('');
                $('#order-search').val('');
                filterOrdersServer();
            });
        });
        function updateStatus(statusId, orderId) {
            $.ajax({
                type: "POST",
                url: "Order",
                data: { statusId: statusId, orderId: orderId },
                success: function (response) {
                    if (response.success) {
                        window.location.reload();
                    } else {
                        alert("Cập nhật trạng thái thất bại!");
                    }
                },
                error: function () {
                    alert("Cập nhật trạng thái thất bại!");
                }
            });
        }

        function confirmStatusChange(statusId, orderId, statusName) {
            if (statusId == 3 || statusId == 5) {
                if (confirm('Bạn có chắc chắn muốn chuyển trạng thái đơn hàng sang "' + statusName + '"? Hành động này sẽ không thể hoàn tác.')) {
                    updateStatus(statusId, orderId);
                }
            } else {
                updateStatus(statusId, orderId);
            }
        }
    </script>
</body>

</html>