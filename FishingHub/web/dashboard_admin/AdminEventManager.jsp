<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

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
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
        <style>
            .sidebar-item.active {
                background-color: rgba(79, 70, 229, 0.1);
                color: #4f46e5;
                border-left: 3px solid #4f46e5;
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
                            <a href="#" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-dashboard-line"></i>
                                </div>
                                Dashboard
                            </a>
                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý người dùng
                            </div>
                            <a href="${pageContext.request.contextPath}/UserManager"
                               class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-user-line"></i>
                                </div>
                                Danh sách người dùng
                            </a>
                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý sự kiện
                            </div>
                            <a href="#"
                               class="sidebar-item active flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-calendar-event-line"></i>
                                </div>
                                Sự kiện
                            </a>
                            <a href="#" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-team-line"></i>
                                </div>
                                Người tham gia
                            </a>
                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý bài viết
                            </div>
                            <a href="PostManagement.jsp"
                               class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-file-list-line"></i>
                                </div>
                                Danh sách bài viết
                            </a>
                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý kiến thức
                            </div>
                            <a href="${pageContext.request.contextPath}/FishManage"
                               class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-book-open-line"></i>
                                </div>
                                Thông tin loài cá
                            </a>
                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Thành tựu & Xếp
                                hạng
                            </div>
                            <a href="#" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-medal-line"></i>
                                </div>
                                Thành tựu
                            </a>
                            <a href="#" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-bar-chart-line"></i>
                                </div>
                                Bảng xếp hạng
                            </a>
                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Thống kê</div>
                            <a href="#" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-line-chart-line"></i>
                                </div>
                                Báo cáo
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
                            <p class="text-sm font-medium text-gray-700">Nguyễn Văn Quản</p>
                            <p class="text-xs font-medium text-gray-500">Quản trị viên</p>
                        </div>
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
                                <!-- Đã xóa thanh tìm kiếm ở đây -->
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Main content area -->
                <main class="flex-1 relative overflow-y-auto focus:outline-none custom-scrollbar">
                    <div class="p-6">
                        <div class="flex items-center justify-between mb-8">
                            <div>
                                <h1 class="text-2xl font-bold text-gray-900">Dashboard</h1>
                                <p class="text-gray-600">Tổng quan quản lý sự kiện</p>
                            </div>
                        </div>
                        <!-- Stats Cards -->
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-sm font-medium text-gray-600">Sự kiện chờ duyệt</p>
                                        <p class="text-2xl font-bold text-gray-900">24</p>
                                        <p class="text-sm text-yellow-600">8 sự kiện mới</p>
                                    </div>
                                    <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center">
                                        <i class="ri-time-fill text-yellow-600 text-xl"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-sm font-medium text-gray-600">Đã duyệt hôm nay</p>
                                        <p class="text-2xl font-bold text-gray-900">12</p>
                                        <p class="text-sm text-green-600">Hoàn thành 80%</p>
                                    </div>
                                    <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                                        <i class="ri-checkbox-circle-fill text-green-600 text-xl"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-sm font-medium text-gray-600">Đã từ chối</p>
                                        <p class="text-2xl font-bold text-gray-900">5</p>
                                        <p class="text-sm text-red-600">Cần phản hồi</p>
                                    </div>
                                    <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center">
                                        <i class="ri-close-circle-fill text-red-600 text-xl"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="bg-white p-6 rounded-lg shadow-sm border border-gray-200">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-sm font-medium text-gray-600">Tổng sự kiện đã duyệt</p>
                                        <p class="text-2xl font-bold text-gray-900">186</p>
                                        <p class="text-sm text-blue-600">Trong tháng này</p>
                                    </div>
                                    <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                                        <i class="ri-calendar-check-fill text-blue-600 text-xl"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="flex flex-col md:flex-row gap-4 mb-6">
                            <!-- Search Form -->
                            <form method="get" action="AdminEventManager"
                                  class="flex-1 flex flex-col sm:flex-row items-stretch sm:items-center bg-white rounded-lg shadow-sm border border-gray-200 p-4 gap-2">

                                <input type="hidden" name="action" value="search">
                                <div class="relative flex-1">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <i class="ri-search-line text-gray-400"></i>
                                    </div>
                                    <input type="text" name="search" value="${search}"
                                           class="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-button text-sm placeholder-gray-400 focus:ring-2 focus:ring-primary focus:ring-opacity-20 focus:border-primary"
                                           placeholder="Tìm kiếm sự kiện..." />
                                </div>
                                <button type="submit"
                                        class="flex-shrink-0 inline-flex items-center justify-center px-4 py-2 bg-primary text-white text-sm font-medium rounded-button hover:bg-primary/90 transition">
                                    <i class="ri-search-line mr-2"></i> Tìm kiếm
                                </button>
                            </form>

                            <!-- Filter Form -->
                            <form method="get" action="AdminEventManager"
                                  class="flex flex-col sm:flex-row items-stretch sm:items-center bg-white rounded-lg shadow-sm border border-gray-200 p-4 gap-2 sm:w-auto w-full">
                                <input type="hidden" name="action" value="filter">
                                <div class="relative w-full sm:w-48">
                                    <select id="event-status-filter" name="status"
                                            class="block w-full pl-3 pr-10 py-2 text-base border border-gray-300 rounded-button appearance-none focus:outline-none focus:ring-2 focus:ring-primary focus:ring-opacity-20 focus:border-primary bg-white text-sm">
                                        <option value="all" <c:if test="${empty filter or filter == 'all'}">selected</c:if>>
                                            Tất cả sự kiện</option>
                                        <option value="pending" <c:if test="${empty filter or filter == 'pending'}">selected</c:if>>
                                            Chờ duyệt </option>
                                        <option value="approved" <c:if test="${empty filter or filter == 'approved'}">selected</c:if>>
                                            Đã duyệt</option>
                                        <option value="rejected" <c:if test="${empty filter or filter == 'rejected'}">selected</c:if>>
                                            Từ chối</option>
                                    </select>
                                    <div class="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
                                        <i class="ri-arrow-down-s-line text-gray-400"></i>
                                    </div>
                                </div>
                                <button type="submit"
                                        class="inline-flex items-center justify-center px-4 py-2 bg-secondary text-white text-sm font-medium rounded-button hover:bg-secondary/90 transition">
                                    <i class="ri-filter-line mr-2"></i> Lọc
                                </button>
                            </form>
                        </div>
                        <div class="bg-white rounded-lg shadow-sm border border-gray-200">
                            <div class="overflow-x-auto">
                                <table class="w-full">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            
                                            <th
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Tên sự kiện</th>
                                            <th
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Ngày tạo</th>
                                            <th
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Người tổ chức</th>
                                            <th
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Thời gian diễn ra</th>
                                            <th
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Trạng thái</th>
                                            <th
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                        <!-- Ví dụ 1 -->
                                        <c:forEach items="${listE}" var="c">
                                            <tr>
                                                
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <div class="font-medium text-gray-900">${c.title}</div>

                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${c.formattedCreatedAt}
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                    <div class=" text-center">
                                                        ${c.fullName}
                                                    </div>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${c.formattedStartDate} -
                                                    ${c.formattedEndDate}</td>
                                                <td class="px-6 py-4 whitespace-nowrap">
                                                    <span class="px-2 py-1 text-xs font-medium rounded-full
                                                          ${c.status == 'pending' ? 'bg-yellow-100 text-yellow-800' : 
                                                            c.status == 'approved' ? 'bg-green-100 text-green-800' : 
                                                            'bg-red-100 text-red-800'}">${c.status}</span>
                                                </td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                                    <div class="flex space-x-2">
                                                        <button class="text-blue-600 hover:text-blue-700"
                                                                title="Xem chi tiết"
                                                                onclick="location.href = 'AdminEventManager?action=detail&eventId=${c.eventId}'"
                                                                >
                                                            <div class="w-4 h-4 flex items-center justify-center">
                                                                <i class="ri-eye-line"></i>
                                                            </div>
                                                        </button>
                                                        <button class="text-green-600 hover:text-green-700"
                                                                title="Chỉnh sửa">
                                                            <div class="w-4 h-4 flex items-center justify-center">
                                                                <i class="ri-edit-line"></i>
                                                            </div>
                                                        </button>
                                                        <button class="text-red-600 hover:text-red-700" title="Xóa">
                                                            <div class="w-4 h-4 flex items-center justify-center">
                                                                <i class="ri-delete-bin-line"></i>
                                                            </div>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                        <!-- Các dòng sự kiện khác giữ nguyên hoặc thêm tại đây -->
                                    </tbody>
                                </table>
                            </div>
                            <div class="px-6 py-4 border-t border-gray-200">
                                <div class="flex items-center justify-between">
                                    <div class="text-sm text-gray-700">
                                        Hiển thị <span class="font-medium">1</span> đến
                                        <span class="font-medium">5</span> của
                                        <span class="font-medium">247</span> kết quả
                                    </div>
                                    <div class="flex items-center space-x-2">
                                        <button
                                            class="px-3 py-1 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 !rounded-button"
                                            disabled>
                                            <div class="flex items-center space-x-1">
                                                <div class="w-3 h-3 flex items-center justify-center">
                                                    <i class="ri-arrow-left-s-line"></i>
                                                </div>
                                                <span>Trước</span>
                                            </div>
                                        </button>
                                        <button class="px-3 py-1 text-sm bg-primary text-white rounded-lg">1</button>
                                        <button
                                            class="px-3 py-1 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 !rounded-button">2</button>
                                        <button
                                            class="px-3 py-1 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 !rounded-button">3</button>
                                        <span class="px-2 text-sm text-gray-500">...</span>
                                        <button
                                            class="px-3 py-1 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 !rounded-button">25</button>
                                        <button
                                            class="px-3 py-1 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 !rounded-button">
                                            <div class="flex items-center space-x-1">
                                                <span>Sau</span>
                                                <div class="w-3 h-3 flex items-center justify-center">
                                                    <i class="ri-arrow-right-s-line"></i>
                                                </div>
                                            </div>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </body>

</html>