<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
        <div class="flex h-screen">
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
                            <a href="#" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
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
                            <a href="#" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-file-list-line"></i>
                                </div>
                                Danh sách bài viết
                            </a>
                            <div class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase">Quản lý kiến thức
                            </div>
                            <a href="#" class="sidebar-item flex items-center px-2 py-2 text-sm font-medium rounded-md">
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
            <div class="flex flex-col flex-1 w-0 overflow-y-auto">
                <header class="bg-white shadow-sm border-b border-gray-200">
                    <div class="px-6 py-4">
                        <div class="flex items-center justify-between">
                            <!-- Đã bỏ nút quay lại -->
                            <h1 class="text-lg font-semibold text-gray-900 mx-auto">Chi tiết sự kiện</h1>
                            <!-- Đã bỏ div w-20 vì không cần căn chỉnh nữa -->
                        </div>
                    </div>
                </header>



                <main class="max-w-4xl mx-auto px-6 py-8">
                    <div class="bg-white rounded-lg shadow-sm overflow-hidden">
                        <div class="relative h-80 bg-gray-100">
                            <img src="assets/img/eventPoster/${event.posterUrl}"
                                 alt="Hình ảnh sự kiện" class="w-full h-full object-cover object-top">
                            <div class="absolute top-4 right-4">
                                <c:choose>
                                    <c:when test="${event.status == 'pending'}">
                                        <span
                                            class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                                            Đang chờ duyệt
                                        </span>
                                    </c:when>
                                    <c:when test="${event.status == 'approved'}">
                                        <span
                                            class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                            Đã duyệt
                                        </span>
                                    </c:when>
                                    <c:when test="${event.status == 'rejected'}">
                                        <span
                                            class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                            Từ chối
                                        </span>
                                    </c:when>

                                </c:choose>

                            </div>
                        </div>

                        <div class="p-8">

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                                <div>
                                    <p class="text-sm text-gray-500 mb-1">Tên sự kiện</p>
                                    <p class="font-semibold text-lg text-primary mb-4">${event.title}</p>

                                    <p class="text-sm text-gray-500 mb-1">Tên hồ câu</p>
                                    <p class="font-medium text-gray-900 mb-4">${event.lakeName}</p>

                                    <p class="text-sm text-gray-500 mb-1">Địa điểm</p>
                                    <p class="font-medium text-gray-900 mb-4">${event.location}</p>

                                    <p class="text-sm text-gray-500 mb-1">Người tổ chức</p>
                                    <p class="font-medium text-gray-900 mb-4">${event.fullName}</p>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-500 mb-1">Thời gian bắt đầu</p>
                                    <p class="font-medium text-gray-900 mb-4">${event.formattedStartTime}</p>

                                    <p class="text-sm text-gray-500 mb-1">Thời gian kết thúc</p>
                                    <p class="font-medium text-gray-900 mb-4">${event.formattedEndTime}</p>

                                    <p class="text-sm text-gray-500 mb-1">Thời gian tạo</p>
                                    <p class="font-medium text-gray-900 mb-4">${event.formattedCreatedAtTime}</p>

                                    <p class="text-sm text-gray-500 mb-1">Ngày duyệt</p>

                                    <p class="font-medium text-gray-900 mb-4">
                                        <c:choose>
                                            <c:when test="${not empty event.formattedApprovedAtTime}">
                                                ${event.formattedApprovedAtTime}
                                            </c:when>
                                            <c:otherwise>
                                                --
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p class="text-sm text-gray-500 mb-1">Trạng thái</p>
                                    <p class="font-medium text-gray-900 mb-4">
                                        <c:choose>
                                            <c:when test="${event.status == 'pending'}">
                                                Chờ duyệt
                                            </c:when>
                                            <c:when test="${event.status == 'approved'}">
                                                Đã duyệt
                                            </c:when>
                                            <c:when test="${event.status == 'rejected'}">
                                                Từ chối
                                            </c:when>
                                            <c:otherwise>
                                                ${event.status}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>


                            <div class="mb-8">
                                <h3 class="text-xl font-semibold text-gray-900 mb-2">Mô tả sự kiện</h3>
                                <div class="prose max-w-none text-gray-700">
                                    <p>
                                        ${event.description}
                                    </p>

                                </div>
                            </div>
                            <div class="flex-1 flex justify-end">
                                <a href="AdminEventManager"
                                   class="bg-gray-200 text-gray-700 px-6 py-3 !rounded-button font-medium hover:bg-gray-300 transition-colors whitespace-nowrap flex items-center gap-2">
                                    <i class="ri-arrow-left-line"></i>
                                    Quay về
                                </a>
                            </div>
                                        <c:if test="${event.status == 'pending'}">      
                            <div class="border-t border-gray-200 pt-8">
                                <div class="bg-blue-50 rounded-lg p-6">
                                    <h3 class="text-lg font-semibold text-gray-900 mb-4 flex items-center gap-2">
                                        <div class="w-5 h-5 flex items-center justify-center">
                                            <i class="ri-admin-line text-primary"></i>
                                        </div>
                                        Phê duyệt sự kiện
                                    </h3>
                                    <p class="text-sm text-gray-600 mb-6">
                                        Xem xét và phê duyệt sự kiện này để cho phép người dùng đăng ký tham gia.
                                    </p>
                                    <div class="flex flex-col sm:flex-row gap-3">
                                        <button id="approveBtn"
                                                class="flex-1 bg-secondary text-white px-6 py-3 !rounded-button font-medium hover:bg-green-600 transition-colors whitespace-nowrap">
                                            <div class="flex items-center justify-center gap-2">
                                                <div class="w-5 h-5 flex items-center justify-center">
                                                    <i class="ri-check-line"></i>
                                                </div>
                                                Duyệt sự kiện
                                            </div>
                                        </button>
                                        <button id="rejectBtn"
                                                class="flex-1 bg-red-500 text-white px-6 py-3 !rounded-button font-medium hover:bg-red-600 transition-colors whitespace-nowrap">
                                            <div class="flex items-center justify-center gap-2">
                                                <div class="w-5 h-5 flex items-center justify-center">
                                                    <i class="ri-close-line"></i>
                                                </div>
                                                Từ chối
                                            </div>
                                        </button>

                                    </div>
                                </div>
                            </div>
                            </c:if> 
                        </div>
                    </div>
                </main>

                <div id="rejectModal"
                     class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 hidden z-50">
                    <div class="bg-white rounded-lg max-w-md w-full p-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4">Từ chối sự kiện</h3>
                        <p class="text-sm text-gray-600 mb-4">
                            Vui lòng nhập lý do từ chối để gửi thông báo cho người tổ chức sự kiện.
                        </p>
                        <div class="mb-6">
                            <label for="rejectReason" class="block text-sm font-medium text-gray-700 mb-2">
                                Lý do từ chối <span class="text-red-500">*</span>
                            </label>
                            <textarea id="rejectReason" rows="4"
                                      class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent resize-none text-sm"
                                      placeholder="Nhập lý do từ chối sự kiện..."></textarea>
                            <p id="errorMessage" class="text-red-500 text-xs mt-1 hidden">Vui lòng nhập lý do từ chối</p>
                        </div>
                        <div class="flex gap-3">
                            <button id="cancelReject"
                                    class="flex-1 px-4 py-2 border border-gray-300 text-gray-700 !rounded-button font-medium hover:bg-gray-50 transition-colors whitespace-nowrap">
                                Hủy
                            </button>
                            <button id="confirmReject"
                                    class="flex-1 px-4 py-2 bg-red-500 text-white !rounded-button font-medium hover:bg-red-600 transition-colors whitespace-nowrap">
                                Xác nhận từ chối
                            </button>
                        </div>
                    </div>
                </div>

                <div id="successModal"
                     class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 hidden z-50">
                    <div class="bg-white rounded-lg max-w-sm w-full p-6 text-center">
                        <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <div class="w-8 h-8 flex items-center justify-center">
                                <i class="ri-check-line text-2xl text-secondary"></i>
                            </div>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-900 mb-2">Thành công!</h3>
                        <p id="successMessage" class="text-sm text-gray-600 mb-4">Sự kiện đã được duyệt thành công.</p>
                        <button id="closeSuccess"
                                class="w-full px-4 py-2 bg-primary text-white !rounded-button font-medium hover:bg-blue-600 transition-colors whitespace-nowrap">
                            Đóng
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const rejectBtn = document.getElementById('rejectBtn');
                const approveBtn = document.getElementById('approveBtn');
                const rejectModal = document.getElementById('rejectModal');
                const successModal = document.getElementById('successModal');
                const cancelReject = document.getElementById('cancelReject');
                const confirmReject = document.getElementById('confirmReject');
                const closeSuccess = document.getElementById('closeSuccess');
                const rejectReason = document.getElementById('rejectReason');
                const errorMessage = document.getElementById('errorMessage');
                const successMessage = document.getElementById('successMessage');
                const eventId = ${event.eventId}; 

                if (approveBtn) {
                    approveBtn.addEventListener('click', function () {
                        fetch('AdminEventManager?action=approve&eventId=' + eventId, {
                            method: 'GET'
                        })
                                .then(response => response.text())
                                .then(() => {
                                    successMessage.textContent = 'Sự kiện đã được duyệt thành công và đã được công khai.';
                                    successModal.classList.remove('hidden');
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                    successMessage.textContent = 'Lỗi khi duyệt sự kiện.';
                                    successModal.classList.remove('hidden');
                                });
                    });
                }

                if (rejectBtn) {
                    rejectBtn.addEventListener('click', function () {
                        rejectModal.classList.remove('hidden');
                        rejectReason.value = '';
                        errorMessage.classList.add('hidden');
                    });
                }

                if (cancelReject) {
                    cancelReject.addEventListener('click', function () {
                        rejectModal.classList.add('hidden');
                    });
                }

                if (confirmReject) {
                    confirmReject.addEventListener('click', function () {
                        const reason = rejectReason.value.trim();
                        if (!reason) {
                            errorMessage.classList.remove('hidden');
                            return;
                        }
                        fetch('AdminEventManager?action=reject&eventId=' + eventId + '&rejectReason=' + encodeURIComponent(reason), {
                            method: 'GET'
                        })
                                .then(response => response.text())
                                .then(() => {
                                    rejectModal.classList.add('hidden');
                                    successMessage.textContent = 'Sự kiện đã được từ chối và thông báo đã được gửi cho người tổ chức.';
                                    successModal.classList.remove('hidden');
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                    rejectModal.classList.add('hidden');
                                    successMessage.textContent = 'Lỗi khi từ chối sự kiện.';
                                    successModal.classList.remove('hidden');
                                });
                    });
                }

                if (closeSuccess) {
                    closeSuccess.addEventListener('click', function () {
                        successModal.classList.add('hidden');
                        // Reload the current event details page to reflect updated status
                        window.location.href = 'AdminEventManager?action=detail&eventId=' + eventId;
                    });
                }

                if (rejectModal) {
                    rejectModal.addEventListener('click', function (e) {
                        if (e.target === rejectModal) {
                            rejectModal.classList.add('hidden');
                        }
                    });
                }

                if (successModal) {
                    successModal.addEventListener('click', function (e) {
                        if (e.target === successModal) {
                            successModal.classList.add('hidden');
                            // Reload the current event details page to reflect updated status
                            window.location.href = 'AdminEventManager?action=detail&eventId=' + eventId;
                        }
                    });
                }

                if (rejectReason) {
                    rejectReason.addEventListener('input', function () {
                        if (this.value.trim()) {
                            errorMessage.classList.add('hidden');
                        }
                    });
                }
            });
        </script>
    </body>

</html>