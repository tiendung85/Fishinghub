<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản lý người dùng</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { 
                        primary: "#4f46e5", 
                        secondary: "#10b981",
                        accent: "#e11d48"
                    },
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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Pacifico&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css" />
    <style>
        body {
            font-family: "Inter", sans-serif;
            background-color: #f9fafb;
        }
        .sidebar-item.active {
            background-color: rgba(79, 70, 229, 0.1);
            color: #4f46e5;
            border-left: 3px solid #4f46e5;
        }
        .custom-scrollbar::-webkit-scrollbar {
            width: 6px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 8px;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #9ca3af;
            border-radius: 8px;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
            background: #6b7280;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f5f9;
            transition: background-color 0.2s ease;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 50;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
            backdrop-filter: blur(4px);
        }
        .modal.show {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .modal-content {
            background-color: #ffffff;
            margin: auto;
            padding: 24px;
            border: none;
            width: 90%;
            max-width: 600px;
            border-radius: 12px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.15);
            animation: slideIn 0.3s ease;
        }
        @keyframes slideIn {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        .action-btn {
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        .action-btn.edit {
            background-color: #4f46e5;
            color: white;
        }
        .action-btn.edit:hover {
            background-color: #4338ca;
        }
        .action-btn.delete {
            background-color: #e11d48;
            color: white;
        }
        .action-btn.delete:hover {
            background-color: #be123c;
        }
        .header-bar {
            display: flex;
            align-items: center;
            padding: 16px 24px;
            background: white;
            border-bottom: 1px solid #e5e7eb;
            gap: 16px;
        }
        .header-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1f2937;
        }
        .action-bar {
            padding: 16px 24px;
            background: white;
            border-bottom: 1px solid #e5e7eb;
        }
        .action-bar a {
            display: inline-block;
            padding: 8px 16px;
            margin-right: 8px;
            background-color: #4f46e5;
            color: white;
            border-radius: 6px;
            font-weight: 500;
            transition: background-color 0.2s ease;
        }
        .action-bar a:hover {
            background-color: #4338ca;
        }
        .search-bar {
            padding: 16px 24px;
            background: white;
        }
        .search-bar form {
            display: flex;
            gap: 12px;
            align-items: center;
        }
        .search-bar input, .search-bar select {
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 0.875rem;
            width: 200px;
        }
        .search-bar button {
            padding: 8px 16px;
            background-color: #4f46e5;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }
        .search-bar button:hover {
            background-color: #4338ca;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            margin: 24px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
            font-size: 0.875rem;
        }
        th {
            background-color: #f9fafb;
            font-weight: 600;
            color: #374151;
        }
        td {
            color: #4b5563;
        }
        .logout-btn {
            width: 100%;
            padding: 10px;
            background-color: #f3f4f6;
            color: #374151;
            border-radius: 6px;
            text-align: center;
            transition: background-color 0.2s ease;
        }
        .logout-btn:hover {
            background-color: #e5e7eb;
        }
    </style>
</head>
<body>
<div class="flex h-screen overflow-hidden">
    <!-- Sidebar -->
    <div class="hidden md:flex md:flex-shrink-0">
        <div class="flex flex-col w-64 bg-white border-r border-gray-200">
            <div class="flex items-center justify-center h-16 px-4 border-b border-gray-200">
                <h1 class="text-2xl font-['Pacifico'] text-primary">FishingHub</h1>
            </div>
            <div class="flex flex-col flex-grow px-2 py-4 overflow-y-auto custom-scrollbar">
                <div class="space-y-1">
                    <div class="px-2 py-2 text-xs font-semibold text-gray-500 uppercase">Tổng quan</div>
                    <a href="dashboard-stats" class="sidebar-item active flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                        <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                            <i class="ri-dashboard-line"></i>
                        </div>
                        Dashboard
                    </a>
                    <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý người dùng</div>
                    <a href="${pageContext.request.contextPath}/UserManager" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                        <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                            <i class="ri-user-line"></i>
                        </div>
                        Danh sách người dùng
                    </a>
                    <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý sự kiện</div>
                    <a href="AdminEventManager" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                        <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                            <i class="ri-calendar-event-line"></i>
                        </div>
                        Sự kiện
                    </a>
                    <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý bài viết</div>
                    <a href="${pageContext.request.contextPath}/PostManagement" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                        <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                            <i class="ri-file-list-line"></i>
                        </div>
                        Danh sách bài viết
                    </a>
                    <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý kiến thức</div>
                    <a href="${pageContext.request.contextPath}/FishManage" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                        <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                            <i class="ri-book-open-line"></i>
                        </div>
                        Thông tin loài cá
                    </a>
                </div>
            </div>
            <div class="flex items-center p-4 border-t border-gray-200">
                <div class="flex-shrink-0">
                    <img class="w-10 h-10 rounded-full" src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20male%20administrator%20with%20short%20black%20hair%2C%20wearing%20a%20business%20casual%20outfit%2C%20looking%20confident%20and%20friendly%2C%20high%20quality%2C%20realistic%2C%20studio%20lighting&width=100&height=100&seq=admin123&orientation=squarish" alt="Admin" />
                </div>
                <div class="ml-3">
                    <p class="text-xs font-medium text-gray-500">Quản trị viên</p>
                </div>
            </div>
            <div class="p-4 border-t border-gray-200">
                <form action="logout" method="post">
                    <button type="submit" class="logout-btn">Đăng Xuất</button>
                </form>
            </div>
        </div>
    </div>
    <!-- Main content -->
    <div class="flex flex-col flex-1 overflow-hidden">
        <div class="header-bar">
        
            <div class="header-title">Quản lý người dùng</div>
        </div>
        
        <div class="search-bar">
            <form method="get" action="UserManager">
                <input type="text" name="search" placeholder="Tìm kiếm theo tên..." value="${param.search != null ? param.search : ''}" />
                <select name="role">
                    <option value="">Tất cả vai trò</option>
                    <c:forEach var="role" items="${roles}">
                        <option value="${role.roleId}" <c:if test="${param.role == (role.roleId + '')}">selected</c:if>>${role.roleName}</option>
                    </c:forEach>
                </select>
                <button type="submit">Tìm kiếm</button>
            </form>
        </div>
        <div class="flex-1 overflow-auto p-6">
            <table class="table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Vai trò</th>
                        <th>Giới tính</th>
                        <th>Ngày sinh</th>
                        <th>Vị trí</th>
                        <th>Lần đăng nhập cuối</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${userList}">
                        <tr>
                            <td>${u.userId}</td>
                            <td>${u.fullName}</td>
                            <td>${u.email}</td>
                            <td>${u.phone}</td>
                            <td>${u.role}</td>
                            <td>${u.gender}</td>
                            <td>${u.dateOfBirth}</td>
                            <td>${u.location}</td>
                            <td>${u.lastLoginTime}</td>
                            <td>${u.status}</td>
                            <td>
                                <a class="action-btn edit" href="EditUser?userId=${u.userId}">Sửa</a>
                                <a class="action-btn delete" href="deleteUser?userId=${u.userId}" onclick="return confirm('Xóa người dùng: ${u.fullName}?');">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>