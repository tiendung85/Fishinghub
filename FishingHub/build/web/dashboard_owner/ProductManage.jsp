<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.Users" %>
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
<!DOCTYPE html>
<html lang="vi">
    <%
        Users currentUser = (Users) session.getAttribute("user");
    %>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Admin Dashboard</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {primary: "#4f46e5", secondary: "#10b981"},
                        borderRadius: {
                            none: "0px",
                            sm: "4px",
                            DEFAULT: "8px",
                            md: "12px",
                            lg: "16px",
                            xl: "20px",
                            "2xl": "24px",
                            "3xl": "32px",
                            full: "9999px",
                            button: "8px",
                        },
                    },
                },
            };
        </script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap"
            rel="stylesheet"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css"
            />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
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
            input[type="checkbox"].custom-checkbox {
                display: none;
            }
            input[type="checkbox"].custom-checkbox + label {
                display: inline-block;
                width: 18px;
                height: 18px;
                border: 2px solid #d1d5db;
                border-radius: 4px;
                cursor: pointer;
                position: relative;
            }
            input[type="checkbox"].custom-checkbox:checked + label {
                background-color: #4f46e5;
                border-color: #4f46e5;
            }
            input[type="checkbox"].custom-checkbox:checked + label:after {
                content: "";
                position: absolute;
                left: 5px;
                top: 2px;
                width: 5px;
                height: 10px;
                border: solid white;
                border-width: 0 2px 2px 0;
                transform: rotate(45deg);
            }
            .switch {
                position: relative;
                display: inline-block;
                width: 40px;
                height: 20px;
            }
            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }
            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #e5e7eb;
                transition: .4s;
                border-radius: 20px;
            }
            .slider:before {
                position: absolute;
                content: "";
                height: 16px;
                width: 16px;
                left: 2px;
                bottom: 2px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }
            input:checked + .slider {
                background-color: #4f46e5;
            }
            input:checked + .slider:before {
                transform: translateX(20px);
            }
            input[type="number"]::-webkit-inner-spin-button,
            input[type="number"]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
        </style>
    </head>
    <body>
        <div class="flex h-screen overflow-hidden">
            <!-- Sidebar -->
            <div class="hidden md:flex md:flex-shrink-0">
                <div class="flex flex-col w-64 bg-white border-r border-gray-200">
                    <div
                        class="flex items-center justify-center h-16 px-4 border-b border-gray-200"
                        >
                        <h1 class="text-2xl font-['Pacifico'] text-primary">FishingHub</h1>
                    </div>
                    <div
                        class="flex flex-col flex-grow px-2 py-4 overflow-y-auto custom-scrollbar"
                        >
                        <div class="space-y-1">
                            <div
                                class="px-2 py-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Tổng quan
                            </div>
                            <a
                                href="#"
                                class="sidebar-item active flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-dashboard-line"></i>
                                </div>
                                Dashboard
                            </a>


                            <div
                                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Quản lý sự kiện
                            </div>
                            <a 
                               class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md ">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-calendar-event-line"></i>
                                </div>
                                Sự kiện
                            </a>
                            <div class="ml-10 mt-1 mb-2 flex flex-col gap-2">
                                <a href="EventManager"
                                   class=" py-1 text-gray-500 hover:text-primary hover:bg-gray-100 rounded transition text-sm">
                                    <i class="ri-list-unordered mr-2"></i>Danh sách sự kiện
                                </a>

                            </div>


                            <div
                                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Quản lý sản phẩm
                            </div>
                            <a
                                href="${pageContext.request.contextPath}/ProductManage"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-shopping-bag-line"></i>
                                </div>
                                Danh sách sản phẩm
                            </a>
                            <a
                                href="Order"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
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
                        <a href="Home" class="flex items-center justify-center w-full bg-primary text-white py-2 rounded-button font-medium hover:bg-primary/90 transition">
                            <i class="ri-arrow-left-line mr-2"></i> Quay lại Trang Chủ
                        </a>
                    </div>
                </div>
            </div>
            <!-- Main content -->
            <div class="flex flex-col flex-1 w-0 overflow-hidden">
                <!-- Top navigation -->
                <div
                    class="relative z-10 flex-shrink-0 flex h-16 bg-white border-b border-gray-200"
                    >
                    <button
                        type="button"
                        class="px-4 border-r border-gray-200 text-gray-500 md:hidden"
                        >
                        <div class="w-6 h-6 flex items-center justify-center">
                            <i class="ri-menu-line"></i>
                        </div>
                    </button>
                    <div class="flex-1 px-4 flex justify-between">
                        <div class="flex-1 flex items-center">
                            <div class="w-full max-w-2xl">
                                <div class="relative w-full">
                                    <div
                                        class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none"
                                        >
                                        <div
                                            class="w-5 h-5 flex items-center justify-center text-gray-400"
                                            >
                                            <i class="ri-search-line"></i>
                                        </div>
                                    </div>
                                    <input
                                        type="text"
                                        class="block w-full pl-10 pr-3 py-2 border border-gray-200 rounded-md text-sm placeholder-gray-500 focus:outline-none focus:ring-1 focus:ring-primary focus:border-primary"
                                        placeholder="Tìm kiếm..."
                                        />
                                </div>
                            </div>
                        </div>
                        <div class="ml-4 flex items-center md:ml-6">
                            <button
                                class="p-1 rounded-full text-gray-400 hover:text-gray-500 focus:outline-none"
                                >
                                <div class="w-6 h-6 flex items-center justify-center">
                                    <i class="ri-notification-3-line"></i>
                                </div>
                            </button>
                            <div class="relative ml-3">
                                <div class="flex items-center">
                                    <span
                                        class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"
                                        >
                                        Online
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="flex items-center justify-between h-16 px-6 bg-white border-b border-gray-200">
                    <div class="flex items-center">
                        <button class="text-gray-500 focus:outline-none md:hidden">
                            <i class="ri-menu-line"></i>
                        </button>
                        <h2 class="text-xl font-semibold text-gray-800">Quản lý thông tin sản phẩm</h2>
                    </div>
                    <div class="flex items-center">
                        <button type="button" id="btnAddFish"
                                class="flex items-center px-4 py-2 text-sm font-medium text-white bg-primary rounded-md hover:bg-primary/90">
                            <i class="ri-add-line mr-2"></i>
                            Thêm sản phẩm mới
                        </button>
                    </div>
                </div>
                <!-- Content Area -->
                <div class="flex-1 p-6 overflow-y-auto">
                    <!-- Search and Filter -->
                    <div class="flex items-center justify-between mb-4">
                        <div class="flex items-center space-x-4">
                            <div class="relative">
                                <input type="text" placeholder="Tìm kiếm..."
                                       class="w-64 px-4 py-2 text-sm border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                                <i class="ri-search-line absolute right-3 top-2.5 text-gray-400"></i>
                            </div>
                        </div>
                    </div>
                    <!-- Fish Species Table -->
                    <div class="bg-white rounded-lg shadow">
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead>
                                    <tr class="bg-gray-100 text-gray-700 text-left">
                                        <th class="px-4 py-3">Tên sản phẩm</th>
                                        <th class="px-4 py-3">Giá tiền</th>
                                        <th class="px-4 py-3">Số lượng sản phẩm trong kho</th>
                                        <th class="px-4 py-3">Số lượng sản phẩm đã bán</th>
                                        <th class="px-4 py-3">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="fish" items="${fishList}">
                                        <tr class="border-b hover:bg-gray-50">
                                            <td class="px-4 py-2 font-semibold">${fish.name}</td>
                                            <td class="px-4 py-2">${fish.price}</td>
                                            <td class="px-4 py-2">${fish.stockQuantity}</td>
                                            <td class="px-4 py-2">${fish.soldQuantity}</td>
                                            <td class="px-4 py-2">
                                                <form action="${pageContext.request.contextPath}/ProductManage"
                                                      method="post" style="display:inline">
                                                    <input type="hidden" name="action" value="edit" />
                                                    <input type="hidden" name="id" value="${fish.productId}" />
                                                    <button type="submit"
                                                            class="text-yellow-500 hover:underline mr-2"
                                                            style="background:none;border:none;padding:0;cursor:pointer"><i
                                                            class="ri-edit-line"></i> Sửa</button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/ProductManage"
                                                      method="post" style="display:inline"
                                                      onsubmit="return confirm('Bạn có chắc muốn xóa?');"
                                                      class="deleteFishForm">
                                                    <input type="hidden" name="action" value="delete" />
                                                    <input type="hidden" name="id" value="${fish.productId}" />
                                                    <button type="submit" class="text-red-500 hover:underline"
                                                            style="background:none;border:none;padding:0;cursor:pointer"><i
                                                            class="ri-delete-bin-line"></i> Xóa</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <!-- Pagination -->
                        <div class="flex items-center justify-between mt-6">
                            <div class="text-sm text-gray-700">
                                Hiển thị <span class="font-medium">${(currentPage-1)*pageSize + 1}</span>
                                đến
                                <span class="font-medium">${endItem}</span>
                                của
                                <span class="font-medium">${totalFish}</span>
                                kết quả
                            </div>
                            <div class="flex items-center space-x-2">
                                <c:if test="${currentPage > 1}">
                                    <a href="${pageContext.request.contextPath}/ProductManage?page=${currentPage-1}"
                                       class="px-3 py-1 rounded bg-gray-200 hover:bg-gray-300">«</a>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <a href="${pageContext.request.contextPath}/ProductManage?page=${i}"
                                       class="px-3 py-1 rounded ${i == currentPage ? 'bg-primary text-white' : 'bg-gray-200 hover:bg-gray-300'}">${i}</a>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <a href="${pageContext.request.contextPath}/ProductManage?page=${currentPage+1}"
                                       class="px-3 py-1 rounded bg-gray-200 hover:bg-gray-300">»</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal chỉnh sửa loài cá -->
                <c:if test="${not empty editFish}">
                    <div id="editFishModal"
                         class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center z-50">
                        <div
                            class="bg-white rounded-lg shadow-lg p-6 w-full max-w-2xl max-h-[90vh] overflow-y-auto">
                            <h2 class="text-2xl font-bold mb-4">Chỉnh sửa sản phẩm</h2>
                            <form id="editFishForm" action="${pageContext.request.contextPath}/ProductManage" method="post">
                                <input type="hidden" name="action" value="edit" />
                                <input type="hidden" name="newData" value="newData" />
                                <input type="hidden" name="id" value="${editFish.productId}" />

                                <div class="grid grid-cols-4 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium">Tên sản phẩm</label>
                                        <input type="text" name="commonName" value="${editFish.name}"
                                               class="w-full border rounded px-3 py-2" required />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Giá tiền</label>
                                        <input type="text" name="scientificName" value="${editFish.price}"
                                               class="w-full border rounded px-3 py-2" required />
                                    </div>                               

                                    <div>
                                        <label class="block text-sm font-medium">Số lượng trong kho</label>
                                        <input type="text" name="bestSeason" value="${editFish.stockQuantity}"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium">Số lượng đã bán</label>
                                        <input type="text" name="sold" value="${editFish.soldQuantity}"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium">Danh Mục</label>
                                        <select name="difficultyLevel" class="w-full border rounded px-3 py-2"
                                                required>
                                            <c:forEach var="fish" items="${cateList}">
                                                <option value="${fish.categoryId}">${fish.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="grid">
                                    <div>
                                        <label class="block text-sm font-medium">Ảnh chính</label>
                                        <input type="file" name="image1" accept="image/*"
                                               class="w-full border rounded px-3 py-2"
                                               onchange="previewImage(event, 'previewImage1')" />
                                        <img id="previewImage1" class="mt-2 w-32 h-32 object-cover rounded"
                                             src="" style="display: none;" alt="Preview Ảnh chính" />
                                    </div>
                                </div>

                                <!-- Nút hành động -->
                                <div class="flex justify-end gap-2">
                                    <button type="button" onclick="closeModal('editFishModal')"
                                            class="bg-gray-500 text-white px-4 py-2 rounded">Hủy</button>
                                    <button type="submit"
                                            class="bg-blue-500 text-white px-4 py-2 rounded">Lưu</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>
                <!-- Add Fish Modal -->
                <c:if test="${param.action eq 'add'}">
                    <div class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50">
                        <div class="bg-white rounded-lg shadow-lg p-8 w-full max-w-2xl relative">
                            <h2 class="text-xl font-bold mb-4">Thêm sản phẩm mới</h2>
                            <form action="${pageContext.request.contextPath}/ProductManage" method="post">
                                <input type="hidden" name="action" value="add" />
                                <input type="hidden" name="a" value="add" />
                                <div class="grid grid-cols-4 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium">Tên sản phẩm</label>
                                        <input type="text" name="commonName"
                                               class="w-full border rounded px-3 py-2" required />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Giá tiền</label>
                                        <input type="text" name="scientificName"
                                               class="w-full border rounded px-3 py-2" required />
                                    </div>                               

                                    <div>
                                        <label class="block text-sm font-medium">Số lượng trong kho</label>
                                        <input type="text" name="bestSeason"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium">Danh Mục</label>
                                        <select name="difficultyLevel" class="w-full border rounded px-3 py-2"
                                                required>
                                            <c:forEach var="fish" items="${cateList}">
                                                <option value="${fish.categoryId}">${fish.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="grid">
                                    <div>
                                        <label class="block text-sm font-medium">Ảnh chính</label>
                                        <input type="file" name="image1" accept="image/*"
                                               class="w-full border rounded px-3 py-2" required
                                               onchange="previewImage(event, 'previewImage1')" />
                                        <img id="previewImage1" class="mt-2 w-32 h-32 object-cover rounded"
                                             src="" style="display: none;" alt="Preview Ảnh chính" />
                                    </div>
                                </div>
                                <div class="flex justify-end space-x-2 mt-4">
                                    <button type="submit" class="bg-primary text-white px-4 py-2 rounded">Thêm
                                        mới</button>
                                    <a href="${pageContext.request.contextPath}/ProductManage"
                                       class="bg-gray-300 text-gray-700 px-4 py-2 rounded">Hủy</a>
                                </div>
                            </form>
                            <button
                                onclick="window.location.href = '${pageContext.request.contextPath}/ProductManage'"
                                class="absolute top-2 right-2 text-gray-400 hover:text-gray-700 text-2xl">×</button>
                        </div>
                    </div>
                </c:if>
                <!-- Thông báo -->
                <c:if test="${not empty requestScope.message}">
                    <script>
                        alert('${requestScope.message}');
                    </script>
                </c:if>
                <!-- JavaScript -->
                <script>
                    function previewImage(event, previewId) {
                        const file = event.target.files[0];
                        const preview = document.getElementById(previewId);
                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                preview.src = e.target.result;
                                preview.style.display = 'block';
                            };
                            reader.readAsDataURL(file);
                        } else {
                            preview.src = '';
                            preview.style.display = 'none';
                        }
                    }
                    function closeModal(modalId) {
                        document.getElementById(modalId).style.display = 'none';
                    }
                    document.addEventListener('DOMContentLoaded', function () {
                        var btnAdd = document.getElementById('btnAddFish');
                        if (btnAdd) {
                            btnAdd.addEventListener('click', function () {
                                window.location.href = '${pageContext.request.contextPath}/ProductManage?action=add';
                            });
                        }
                    });
                </script>
            </div>
        </div>
    </body>

</html>