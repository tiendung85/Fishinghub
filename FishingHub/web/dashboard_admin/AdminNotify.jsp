<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Thông báo duyệt/từ chối bài viết</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: { primary: "#4f46e5", secondary: "#10b981" },
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
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        #notificationTable .table {
            width: 100%;
            table-layout: fixed;
            border-collapse: collapse;
        }
        #notificationTable .table th,
        #notificationTable .table td {
            word-wrap: break-word;
            overflow-wrap: break-word;
            max-width: 0;
            padding: 0.75rem;
            border: 1px solid #e5e7eb; /* Tailwind gray-200 */
        }
        #notificationTable .table th {
            background-color: #f9fafb; /* Màu nền tiêu đề bảng */
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem; /* text-xs */
            color: #6b7280; /* text-gray-500 */
        }
        #notificationTable .table th:nth-child(1) { width: 20%; }
        #notificationTable .table th:nth-child(2) { width: 35%; }
        #notificationTable .table th:nth-child(3) { width: 20%; }
        #notificationTable .table th:nth-child(4) { width: 25%; }
        #notificationTable .table td {
            font-size: 0.875rem; /* text-sm */
            color: #374151; /* text-gray-700 */
        }
        #notificationTable .table tbody tr:hover {
            background-color: #f1f5f9; /* hover:bg-gray-50 */
        }
        #notificationTable {
            max-height: 500px; /* Giới hạn chiều cao bảng */
            overflow-y: auto; /* Cho phép cuộn dọc */
        }
    </style>
</head>
<body>
    <div class="flex min-h-screen">
        <!-- Sidebar -->
        <div class="hidden md:flex md:flex-shrink-0">
            <div class="flex flex-col w-64 bg-white border-r border-gray-200">
                <div class="flex items-center justify-center h-16 px-4 border-b border-gray-200">
                    <h1 class="text-2xl font-['Pacifico'] text-primary">FishingHub</h1>
                </div>
                <div class="flex flex-col flex-grow px-2 py-4 overflow-y-auto custom-scrollbar">
                    <div class="space-y-1">
                        <div class="px-2 py-2 text-xs font-semibold text-gray-500 uppercase">Tổng quan</div>
                        <a href="dashboard-stats" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"><i class="ri-dashboard-line"></i></div>
                            Dashboard
                        </a>
                        <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý người dùng</div>
                        <a href="${pageContext.request.contextPath}/UserManager" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"><i class="ri-user-line"></i></div>
                            Danh sách người dùng
                        </a>
                        <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý sự kiện</div>
                        <a href="AdminEventManager" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"><i class="ri-calendar-event-line"></i></div>
                            Sự kiện
                        </a>
                        <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý bài viết</div>
                        <a href="${pageContext.request.contextPath}/PostManagement" class="sidebar-item active flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"><i class="ri-file-list-line"></i></div>
                            Danh sách bài viết
                        </a>
                        <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý kiến thức</div>
                        <a href="${pageContext.request.contextPath}/FishManage" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary">
                            <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"><i class="ri-book-open-line"></i></div>
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
                    <form action="logout" method="post" style="display:inline;">
                        <button type="submit" class="bg-gray-200 text-gray-800 px-3 py-2 rounded-button hover:bg-gray-300">Đăng Xuất</button>
                    </form>
                </div>
            </div>
        </div>
        <!-- Main content -->
        <div class="flex flex-col flex-1 w-0 overflow-y-auto">
            <div class="container mx-auto py-6 px-4 sm:px-6 md:px-8">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-2xl font-bold text-gray-900">
                        <i class="ri-notification-line mr-2"></i>
                        Thông báo duyệt/từ chối bài viết
                    </h2>
                </div>
                
               
                
                <div class="mb-6">
                    <form id="notificationFilterForm" class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <div class="relative">
                                <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500"><i class="ri-search-line"></i></span>
                                <input type="text" id="notificationSearch" class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary" placeholder="Tìm kiếm theo tiêu đề bài viết...">
                            </div>
                        </div>
                        <div>
                            <div class="relative">
                                <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500"><i class="ri-calendar-line"></i></span>
                                <input type="date" id="notificationDate" class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary">
                            </div>
                        </div>
                    </form>
                </div>
                <div id="notificationTable" class="bg-white shadow rounded-lg p-6">
                    <p>Đang tải thông báo...</p>
                </div>
            </div>
        </div>
        <div class="text-right pr-8 mb-2">
            <a href="PostManagement" class="inline-flex items-center text-sm font-semibold text-blue-600 hover:text-blue-800 transition">
                <i class="ri-arrow-left-line mr-1 text-base"></i> Quay lại
            </a>
        </div>
    </div>
   
    <script>
        function loadNotifications(search, date) {
            $.ajax({
                url: '${pageContext.request.contextPath}/AdminNotify',
                type: 'GET',
                data: { 
                    action: 'getAllNotifications',
                    search: search,
                    date: date
                },
                success: function(data) {
                    console.log('AJAX Response:', data); // Debug
                    if (data.trim() === '' || !data.includes('<table')) {
                        $('#notificationTable').html('<p class="text-gray-500 text-center">Không có thông báo duyệt/từ chối nào.</p>');
                    } else {
                        $('#notificationTable').html(data);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('AJAX Error:', error, 'Status:', status, 'Response:', xhr.responseText); // Debug
                    $('#notificationTable').html('<p class="text-red-500 text-center">Lỗi khi tải thông báo. Vui lòng thử lại.</p>');
                }
            });
        }

        // Load notifications on page load
        $(document).ready(function() {
            loadNotifications('', '');
        });

        // Event listeners for search and date filter
        $('#notificationSearch').on('input', function() {
            var search = $(this).val();
            var date = $('#notificationDate').val();
            loadNotifications(search, date);
        });

        $('#notificationDate').on('change', function() {
            var search = $('#notificationSearch').val();
            var date = $(this).val();
            loadNotifications(search, date);
        });
    </script>
</body>
</html>