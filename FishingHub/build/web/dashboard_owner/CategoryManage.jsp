<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Users" %>
<%
    Users currentUser = (Users) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Danh Mục - FishingHub</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: '#1E88E5',
                            secondary: '#FFA726',
                            accent: '#4CAF50',
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
                        },
                        fontFamily: {
                            'pacifico': ['Pacifico', 'cursive'],
                            'roboto': ['Roboto', 'sans-serif']
                        }
                    }
                }
            }
        </script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f4f6f9;
            }
            .sidebar {
                transition: transform 0.3s ease-in-out;
                width: 250px;
                background: linear-gradient(180deg, #ffffff 0%, #f8f9fa 100%);
            }
            .sidebar-hidden {
                transform: translateX(-100%);
            }
            .sidebar-open {
                transform: translateX(0);
            }
            .sidebar-item.active {
                background-color: #e3f2fd;
                color: #1E88E5;
                font-weight: 500;
                border-left: 4px solid #1E88E5;
            }
            .sidebar-item:hover {
                background-color: #f8f9fa;
                color: #1E88E5;
                transition: all 0.2s ease;
            }
            .modal-content {
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            }
            .btn-primary, .btn-success, .btn-warning, .btn-danger, .btn-secondary, .btn-info {
                border-radius: 8px;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }
            .btn-primary:hover, .btn-success:hover, .btn-warning:hover, .btn-danger:hover, .btn-secondary:hover, .btn-info:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .table th, .table td {
                vertical-align: middle;
            }
            .alert {
                border-radius: 8px;
                animation: fadeIn 0.5s ease-in;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
            .backdrop {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 999;
            }
            .sidebar-open ~ .backdrop {
                display: block;
            }
            @media (max-width: 767.98px) {
                .sidebar {
                    position: fixed;
                    z-index: 1000;
                    height: 100vh;
                    transform: translateX(-100%);
                }
                .content {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>
        <div class="flex h-screen overflow-hidden">
            <!-- Sidebar -->
            <div class="sidebar md:flex md:flex-shrink-0 bg-white border-r border-gray-200" id="sidebar">
                <div class="flex flex-col w-64">
                    <div class="flex items-center justify-center h-16 px-4 border-b border-gray-200">
                        <h1 class="text-2xl font-pacifico text-primary">FishingHub</h1>
                    </div>
                    <div class="flex flex-col flex-grow px-2 py-4 overflow-y-auto">
                        <div class="space-y-1">
                            <div class="px-2 py-2 text-xs font-semibold text-gray-500 uppercase">Tổng quan</div>
                            <a href="OwnerDashboard" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary <%= request.getServletPath().equals("/OwnerDashboard") ? "active" : "" %>">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-dashboard-line"></i>
                                </div>
                                Dashboard
                            </a>

                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý sự kiện</div>
                            <a href="#" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-calendar-event-line"></i>
                                </div>
                                Sự kiện
                            </a>
                            <div class="ml-10 mt-1 mb-2 flex flex-col gap-2">
                                <button
                                    onclick="location.href = 'EventManager'"
                                    class="py-1 text-gray-500 hover:text-primary hover:bg-gray-100 rounded transition text-sm"
                                    >
                                    <i class="ri-list-unordered mr-2"></i>Danh sách sự kiện
                                </button>
                                <button onclick="location.href = 'NotificationHistory'" class="py-1 text-gray-500 hover:text-primary hover:bg-gray-100 rounded transition text-sm">
                                    <i class="ri-notification-line mr-2"></i>Lịch sử thông báo
                                </button>
                            </div>

                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý sản phẩm</div>
                            <a href="${pageContext.request.contextPath}/ProductManage" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary <%= request.getServletPath().equals("/ProductManage") ? "active" : "" %>">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-shopping-bag-line"></i>
                                </div>
                                Danh sách sản phẩm
                            </a>
                            <a href="Order" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary <%= request.getServletPath().equals("/Order") ? "active" : "" %>">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-shopping-cart-line"></i>
                                </div>
                                Đơn hàng
                            </a>

                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý danh mục</div>
                            <a href="CategoryManage" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary <%= request.getServletPath().equals("/CategoryManage") ? "active" : "" %>">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-list-unordered"></i>
                                </div>
                                Danh sách danh mục
                            </a>
                        </div>
                    </div>
                    <div class="flex items-center p-4 border-t border-gray-200">
                        <div class="flex-shrink-0">
                            <img class="w-10 h-10 rounded-full" src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20male%20administrator%20with%20short%20black%20hair%2C%20wearing%20a%20business%20casual%20outfit%2C%20looking%20confident%20and%20friendly%2C%20high%20quality%2C%20realistic%2C%20studio%20lighting&width=100&height=100&seq=admin123&orientation=squarish" alt="Admin" />
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-700">
                                <%= currentUser != null ? currentUser.getFullName() : "Khách" %>
                            </p>
                            <p class="text-xs font-medium text-gray-500">
                                <% if (currentUser != null && currentUser.getRoleId() == 2) { %>
                                Chủ Hồ Câu
                                <% } else { %>
                                Quản trị viên
                                <% } %>
                            </p>
                        </div>
                    </div>
                    <div class="p-4">
                        <a href="Home" class="flex items-center justify-center w-full bg-primary text-white py-2 rounded-button font-medium hover:bg-primary/90 transition">
                            <i class="ri-arrow-left-line mr-2"></i> Quay lại Trang Chủ
                        </a>
                    </div>
                </div>
            </div>
            <div class="backdrop" id="backdrop"></div>

            <!-- Main Content -->
            <div class="flex flex-col flex-1 w-0 overflow-hidden">
                <div class="relative z-10 flex-shrink-0 flex h-16 bg-white border-b border-gray-200">
                    <button class="px-4 border-r border-gray-200 text-gray-500 md:hidden" id="toggleSidebar">
                        <div class="w-6 h-6 flex items-center justify-center">
                            <i class="ri-menu-line"></i>
                        </div>
                    </button>
                    <div class="flex-1 flex items-center px-4">
                        <h2 class="text-lg font-semibold text-gray-800">Quản Lý Danh Mục</h2>
                    </div>
                </div>

                <main class="w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 overflow-x-auto">
                    <div class="container">
                        <!-- Search bar -->
                        <form action="CategoryManage" method="get" class="mb-5">
                            <div class="input-group">
                                <input type="text" name="search" value="${search}" placeholder="Tìm kiếm danh mục..." class="form-control rounded-l-md border-gray-300 focus:ring-primary focus:border-primary transition duration-200">
                                <button type="submit" class="btn btn-primary rounded-r-md">Tìm kiếm</button>
                            </div>
                        </form>

                        <!-- Add new category button -->
                        <button type="button" class="btn btn-success mb-4" data-bs-toggle="modal" data-bs-target="#addModal">
                            <i class="ri-add-line mr-1"></i> Thêm danh mục mới
                        </button>

                        <!-- Category table -->
                        <div class="bg-white shadow-md rounded-lg overflow-hidden">
                            <table class="table table-bordered table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th scope="col" class="p-3 text-left">ID</th>
                                        <th scope="col" class="p-3 text-left">Tên</th>
                                        <th scope="col" class="p-3 text-left">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="category" items="${categoryList}">
                                        <tr>
                                            <td class="p-3">${category.categoryId}</td>
                                            <td class="p-3">${category.name}</td>
                                            <td class="p-3">
                                                <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#detailModal${category.categoryId}">
                                                    <i class="ri-eye-line mr-1"></i> Xem chi tiết
                                                </button>
                                                <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal${category.categoryId}">
                                                    <i class="ri-edit-line mr-1"></i> Sửa
                                                </button>
                                                <form action="CategoryManage" method="post" class="d-inline">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="id" value="${category.categoryId}">
                                                    <button type="submit" onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')" class="btn btn-danger btn-sm">
                                                        <i class="ri-delete-bin-line mr-1"></i> Xóa
                                                    </button>
                                                </form>
                                                <!-- Edit modal for each category -->
                                                <div class="modal fade" id="editModal${category.categoryId}" tabindex="-1" aria-labelledby="editModalLabel${category.categoryId}" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="editModalLabel${category.categoryId}">Sửa danh mục</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <form action="CategoryManage" method="post">
                                                                <div class="modal-body">
                                                                    <input type="hidden" name="action" value="edit">
                                                                    <input type="hidden" name="id" value="${category.categoryId}">
                                                                    <div class="mb-3">
                                                                        <label for="editCategoryName${category.categoryId}" class="form-label font-medium">Tên danh mục:</label>
                                                                        <input type="text" name="newName" id="editCategoryName${category.categoryId}" value="${category.name}" required class="form-control rounded-md border-gray-300 focus:ring-primary focus:border-primary transition duration-200">
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Detail modal for each category -->
                                                <div class="modal fade" id="detailModal${category.categoryId}" tabindex="-1" aria-labelledby="detailModalLabel${category.categoryId}" aria-hidden="true">
                                                    <div class="modal-dialog modal-lg">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="detailModalLabel${category.categoryId}">Sản phẩm thuộc danh mục: ${category.name}</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <c:choose>
                                                                    <c:when test="${empty categoryProducts[category.categoryId]}">
                                                                        <p class="text-gray-500">Không có sản phẩm nào thuộc danh mục này.</p>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <table class="table table-bordered table-hover">
                                                                            <thead class="table-light">
                                                                                <tr>
                                                                                    <th scope="col">ID</th>
                                                                                    <th scope="col">Tên sản phẩm</th>
                                                                                    <th scope="col">Giá</th>
                                                                                    <th scope="col">Số lượng tồn</th>
                                                                                    <th scope="col">Số lượng đã bán</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <c:forEach var="product" items="${categoryProducts[category.categoryId]}">
                                                                                    <tr>
                                                                                        <td>${product.productId}</td>
                                                                                        <td>${product.name}</td>
                                                                                        <td>${product.price}</td>
                                                                                        <td>${product.stockQuantity}</td>
                                                                                        <td>${product.soldQuantity}</td>
                                                                                    </tr>
                                                                                </c:forEach>
                                                                            </tbody>
                                                                        </table>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="CategoryManage?page=${currentPage - 1}&search=${search}">Previous</a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="CategoryManage?page=${i}&search=${search}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="CategoryManage?page=${currentPage + 1}&search=${search}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>

                        <!-- Add modal -->
                        <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="addModalLabel">Thêm danh mục mới</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <form action="CategoryManage" method="post">
                                        <div class="modal-body">
                                            <input type="hidden" name="action" value="add">
                                            <div class="mb-3">
                                                <label for="categoryName" class="form-label font-medium">Tên danh mục:</label>
                                                <input type="text" name="name" id="categoryName" required class="form-control rounded-md border-gray-300 focus:ring-primary focus:border-primary transition duration-200">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary">Thêm</button>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Message display -->
                        <c:if test="${message != null}">
                            <div class="alert alert-success mt-4" role="alert">${message}</div>
                            <c:remove var="message" scope="session"/>
                        </c:if>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
        <script>
                                                        const toggleSidebar = document.getElementById('toggleSidebar');
                                                        const sidebar = document.getElementById('sidebar');
                                                        const backdrop = document.getElementById('backdrop');

                                                        toggleSidebar.addEventListener('click', function () {
                                                            sidebar.classList.toggle('sidebar-open');
                                                            sidebar.classList.toggle('sidebar-hidden');
                                                            backdrop.classList.toggle('sidebar-open');
                                                        });

                                                        backdrop.addEventListener('click', function () {
                                                            sidebar.classList.remove('sidebar-open');
                                                            sidebar.classList.add('sidebar-hidden');
                                                            backdrop.classList.remove('sidebar-open');
                                                        });
        </script>
    </body>
</html>