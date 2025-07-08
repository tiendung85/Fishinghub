<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            href="https://fonts.googleapis.com/css2?family=Pacifico&family=Inter:wght@400;500;600;700&display=swap"
            rel="stylesheet" />
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
        <style>
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

            input[type="checkbox"].custom-checkbox+label {
                display: inline-block;
                width: 18px;
                height: 18px;
                border: 2px solid #d1d5db;
                border-radius: 4px;
                cursor: pointer;
                position: relative;
            }

            input[type="checkbox"].custom-checkbox:checked+label {
                background-color: #4f46e5;
                border-color: #4f46e5;
            }

            input[type="checkbox"].custom-checkbox:checked+label:after {
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

            input:checked+.slider {
                background-color: #4f46e5;
            }

            input:checked+.slider:before {
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
                        <h1 class="text-2xl font-['Pacifico'] text-primary">logo</h1>
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
                                Quản lý người dùng
                            </div>
                            <a
                                href="#"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-user-line"></i>
                                </div>
                                Danh sách người dùng
                            </a>
                            <a
                                href="#"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-shield-user-line"></i>
                                </div>
                                Phân quyền
                            </a>

                            <div
                                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Quản lý bài viết
                            </div>
                            <a
                                href="#"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-file-list-line"></i>
                                </div>
                                Danh sách bài viết
                            </a>
                            <a
                                href="#"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-check-double-line"></i>
                                </div>
                                Duyệt bài viết
                            </a>

                            <div
                                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Quản lý kiến thức
                            </div>
                            <a
                                href="${pageContext.request.contextPath}/FishManage"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500">
                                    <i class="ri-book-open-line"></i>
                                </div>
                                Thông tin loài cá
                            </a>
                            <div
                                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Thành tựu & Xếp hạng
                            </div>
                            <a
                                href="#"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-medal-line"></i>
                                </div>
                                Thành tựu
                            </a>
                            <a
                                href="#"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-bar-chart-line"></i>
                                </div>
                                Bảng xếp hạng
                            </a>
                            <div
                                class="px-2 pt-4 pb-2 text-xs font-semibold text-gray-500 uppercase"
                                >
                                Thống kê
                            </div>
                            <a
                                href="#"
                                class="sidebar-item flex items-center px-2 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-primary"
                                >
                                <div
                                    class="w-6 h-6 mr-3 flex items-center justify-center text-gray-500"
                                    >
                                    <i class="ri-line-chart-line"></i>
                                </div>
                                Báo cáo
                            </a>
                        </div>
                    </div>
                    <div class="flex items-center p-4 border-t border-gray-200">
                        <div class="flex-shrink-0">
                            <img
                                class="w-10 h-10 rounded-full"
                                src="https://readdy.ai/api/search-image?query=professional%20headshot%20of%20a%20Vietnamese%20male%20administrator%20with%20short%20black%20hair%2C%20wearing%20a%20business%20casual%20outfit%2C%20looking%20confident%20and%20friendly%2C%20high%20quality%2C%20realistic%2C%20studio%20lighting&width=100&height=100&seq=admin123&orientation=squarish"
                                alt="Admin"
                                />
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-700">Nguyễn Văn Quản</p>
                            <p class="text-xs font-medium text-gray-500">Quản trị viên</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Main Content -->
            <div class="flex flex-col flex-1 overflow-hidden">
                <!-- Top Navigation -->
                <div class="flex items-center justify-between h-16 px-6 bg-white border-b border-gray-200">
                    <div class="flex items-center">
                        <button class="text-gray-500 focus:outline-none md:hidden">
                            <i class="ri-menu-line"></i>
                        </button>
                        <h2 class="text-xl font-semibold text-gray-800">Quản lý thông tin loài cá</h2>
                    </div>
                    <div class="flex items-center">
                        <button type="button" id="btnAddFish"
                                class="flex items-center px-4 py-2 text-sm font-medium text-white bg-primary rounded-md hover:bg-primary/90">
                            <i class="ri-add-line mr-2"></i>
                            Thêm loài cá mới
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
                            <select
                                class="px-4 py-2 text-sm border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary">
                                <option value="">Tất cả độ khó</option>
                                <option value="1">Dễ</option>
                                <option value="2">Trung bình</option>
                                <option value="3">Khó</option>
                            </select>
                        </div>
                    </div>
                    <!-- Fish Species Table -->
                    <div class="bg-white rounded-lg shadow">
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead>
                                    <tr class="bg-gray-100 text-gray-700 text-left">
                                        <th class="px-4 py-3">Tên thường gọi</th>
                                        <th class="px-4 py-3">Tên khoa học</th>
                                        <th class="px-4 py-3">Độ khó</th>
                                        <th class="px-4 py-3">Mùa câu tốt nhất</th>
                                        <th class="px-4 py-3">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="fish" items="${fishList}">
                                        <tr class="border-b hover:bg-gray-50">
                                            <td class="px-4 py-2 font-semibold">${fish.commonName}</td>
                                            <td class="px-4 py-2">${fish.scientificName}</td>
                                            <td class="px-4 py-2">${fish.difficultyLevel}</td>
                                            <td class="px-4 py-2">${fish.bestSeason}</td>
                                            <td class="px-4 py-2">
                                                <form action="${pageContext.request.contextPath}/FishManage"
                                                      method="post" style="display:inline">
                                                    <input type="hidden" name="action" value="edit" />
                                                    <input type="hidden" name="id" value="${fish.id}" />
                                                    <button type="submit"
                                                            class="text-yellow-500 hover:underline mr-2"
                                                            style="background:none;border:none;padding:0;cursor:pointer"><i
                                                            class="ri-edit-line"></i> Sửa</button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/FishManage"
                                                      method="post" style="display:inline"
                                                      onsubmit="return confirm('Bạn có chắc muốn xóa?');"
                                                      class="deleteFishForm">
                                                    <input type="hidden" name="action" value="delete" />
                                                    <input type="hidden" name="id" value="${fish.id}" />
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
                                    <a href="${pageContext.request.contextPath}/FishManage?page=${currentPage-1}"
                                       class="px-3 py-1 rounded bg-gray-200 hover:bg-gray-300">«</a>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <a href="${pageContext.request.contextPath}/FishManage?page=${i}"
                                       class="px-3 py-1 rounded ${i == currentPage ? 'bg-primary text-white' : 'bg-gray-200 hover:bg-gray-300'}">${i}</a>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <a href="${pageContext.request.contextPath}/FishManage?page=${currentPage+1}"
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
                            <h2 class="text-2xl font-bold mb-4">Chỉnh sửa loài cá</h2>
                            <form id="editFishForm" action="${pageContext.request.contextPath}/FishManage"
                                  method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="edit" />
                                <input type="hidden" name="id" value="${editFish.id}" />
                                <!-- Thông tin cá -->
                                <div class="grid grid-cols-2 gap-4 mb-4">
                                    <div>
                                        <label class="block text-sm font-medium">Tên thường gọi</label>
                                        <input type="text" name="commonName" value="${editFish.commonName}"
                                               required class="form-control w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Tên khoa học</label>
                                        <input type="text" name="scientificName"
                                               value="${editFish.scientificName}"
                                               class="form-control w-full border rounded px-3 py-2" />
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium">Mô tả</label>
                                    <textarea name="description" rows="4"
                                              class="form-control w-full border rounded px-2">${editFish.description}</textarea>
                                </div>
                                <div class="grid grid-cols-2 gap-4 mb-4">
                                    <div>
                                        <label class="block text-sm font-medium">Mồi câu</label>
                                        <input type="text" name="bait" value="${editFish.bait}"
                                               class="form-control w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Mùa tốt nhất</label>
                                        <input type="text" name="bestSeason" value="${editFish.bestSeason}"
                                               class="form-control w-full border rounded px-3 py-2" />
                                    </div>
                                </div>
                                <div class="grid grid-cols-2 gap-4 mb-4">
                                    <div>
                                        <label class="block text-sm font-medium">Thời điểm trong ngày</label>
                                        <input type="text" name="bestTimeOfDay"
                                               value="${editFish.bestTimeOfDay}"
                                               class="form-control w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Địa điểm câu</label>
                                        <input type="text" name="fishingSpots" value="${editFish.fishingSpots}"
                                               class="form-control w-full border rounded px-3 py-2" />
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium">Kỹ thuật câu</label>
                                    <textarea name="fishingTechniques" rows="2"
                                              class="form-control w-full border rounded px-3 py-2">${editFish.fishingTechniques}</textarea>
                                </div>
                                <div class="grid grid-cols-2 gap-4 mb-4">
                                    <div>
                                        <label class="block text-sm font-medium">Độ khó (1-5)</label>
                                        <input type="number" name="difficultyLevel"
                                               value="${editFish.difficultyLevel}" min="1" max="5" required
                                               class="w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Trọng lượng trung bình
                                            (kg)</label>
                                        <input type="number" name="averageWeightKg"
                                               value="${editFish.averageWeightKg}" step="0.01"
                                               class="form-control w-full border rounded px-3 py-2" />
                                    </div>
                                </div>
                                <div class="grid grid-cols-2 gap-4 mb-4">
                                    <div>
                                        <label class="block text-sm font-medium">Chiều dài trung bình
                                            (cm)</label>
                                        <input type="number" name="averageLengthCm" value="${editFish.length}"
                                               step="0.1" class="form-control w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Môi trường sống</label>
                                        <input type="text" name="habitat" value="${editFish.habitat}"
                                               class="form-control w-full border rounded px-3 py-2" />
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium">Hành vi</label>
                                    <textarea name="behavior" rows="4"
                                              class="form-control w-full border rounded px-3 py-2">${editFish.behavior}</textarea>
                                </div>
                                <div class="mb-4">
                                    <label class="block text-sm font-medium">Mẹo</label>
                                    <textarea name="tips" rows="2"
                                              class="form-control w-full border rounded px-3 py-2">${editFish.tips}</textarea>
                                </div>
                                <!-- Hiển thị và chỉnh sửa ảnh -->
                                <div class="grid grid-cols-3 gap-4 mb-4">
                                    <div>
                                        <label class="block text-sm font-medium">Ảnh chính</label>
                                        <input type="file" name="image1" accept="image/*"
                                               class="w-full border rounded px-3 py-2"
                                               onchange="previewImage(event, 'previewImage1')" />
                                        <c:if
                                            test="${not empty editFish.images and editFish.images.size() > 0}">
                                            <img id="previewImage1" class="mt-2 w-32 h-32 object-cover rounded"
                                                 src="${editFish.images[0]}" alt="Preview Ảnh chính" />
                                        </c:if>
                                        <c:if test="${empty editFish.images or editFish.images.size() == 0}">
                                            <img id="previewImage1" class="mt-2 w-32 h-32 object-cover rounded"
                                                 src="" style="display: none;" alt="Preview Ảnh chính" />
                                        </c:if>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Ảnh phụ 1</label>
                                        <input type="file" name="image2" accept="image/*"
                                               class="w-full border rounded px-3 py-2"
                                               onchange="previewImage(event, 'previewImage2')" />
                                        <c:if
                                            test="${not empty editFish.images and editFish.images.size() > 1}">
                                            <img id="previewImage2" class="mt-2 w-32 h-32 object-cover rounded"
                                                 src="${editFish.images[1]}" alt="Preview Ảnh phụ 1" />
                                        </c:if>
                                        <c:if test="${empty editFish.images or editFish.images.size() <= 1}">
                                            <img id="previewImage2" class="mt-2 w-32 h-32 object-cover rounded"
                                                 src="" style="display: none;" alt="Preview Ảnh phụ 1" />
                                        </c:if>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Ảnh phụ 2</label>
                                        <input type="file" name="image3" accept="image/*"
                                               class="w-full border rounded px-3 py-2"
                                               onchange="previewImage(event, 'previewImage3')" />
                                        <c:if
                                            test="${not empty editFish.images and editFish.images.size() > 2}">
                                            <img id="previewImage3" class="mt-2 w-32 h-32 object-cover rounded"
                                                 src="${editFish.images[2]}" alt="Preview Ảnh phụ 2" />
                                        </c:if>
                                        <c:if test="${empty editFish.images or editFish.images.size() <= 2}">
                                            <img id="previewImage3" class="mt-2 w-32 h-32 object-cover rounded"
                                                 src="" style="display: none;" alt="Preview Ảnh phụ 2" />
                                        </c:if>
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
                            <h2 class="text-xl font-bold mb-4">Thêm loài cá mới</h2>
                            <form action="${pageContext.request.contextPath}/FishManage" method="post"
                                  enctype="multipart/form-data" class="space-y-4" id="addFishForm">
                                <input type="hidden" name="action" value="add" />
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium">Tên thường gọi</label>
                                        <input type="text" name="commonName"
                                               class="w-full border rounded px-3 py-2" required />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Tên khoa học</label>
                                        <input type="text" name="scientificName"
                                               class="w-full border rounded px-3 py-2" required />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Độ khó</label>
                                        <select name="difficultyLevel" class="w-full border rounded px-3 py-2"
                                                required>
                                            <option value="1">1 - Dễ</option>
                                            <option value="2">2 - Trung bình</option>
                                            <option value="3">3 - Khó</option>
                                            <option value="4">4 - Rất khó</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Mùa câu tốt nhất</label>
                                        <input type="text" name="bestSeason"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Trọng lượng TB (kg)</label>
                                        <input type="number" step="0.01" name="averageWeightKg"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Chiều dài TB (cm)</label>
                                        <input type="number" step="0.01" name="averageLengthCm"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium">Mô tả</label>
                                    <textarea name="description" class="w-full border rounded px-3 py-2"
                                              rows="2"></textarea>
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium">Mồi câu</label>
                                        <input type="text" name="bait"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Thời điểm tốt nhất</label>
                                        <input type="text" name="bestTimeOfDay"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Địa điểm câu</label>
                                        <input type="text" name="fishingSpots"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Kỹ thuật câu</label>
                                        <input type="text" name="fishingTechniques"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium">Môi trường sống</label>
                                        <input type="text" name="habitat"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Tập tính</label>
                                        <input type="text" name="behavior"
                                               class="w-full border rounded px-3 py-2" />
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium">Mẹo câu cá</label>
                                    <input type="text" name="tips" class="w-full border rounded px-3 py-2" />
                                </div>
                                <!-- Thêm các trường ảnh -->
                                <div class="grid grid-cols-3 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium">Ảnh chính</label>
                                        <input type="file" name="image1" accept="image/*"
                                               class="w-full border rounded px-3 py-2" required
                                               onchange="previewImage(event, 'previewImage1')" />
                                        <img id="previewImage1" class="mt-2 w-32 h-32 object-cover rounded"
                                             src="" style="display: none;" alt="Preview Ảnh chính" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Ảnh phụ 1</label>
                                        <input type="file" name="image2" accept="image/*"
                                               class="w-full border rounded px-3 py-2"
                                               onchange="previewImage(event, 'previewImage2')" />
                                        <img id="previewImage2" class="mt-2 w-32 h-32 object-cover rounded"
                                             src="" style="display: none;" alt="Preview Ảnh phụ 1" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium">Ảnh phụ 2</label>
                                        <input type="file" name="image3" accept="image/*"
                                               class="w-full border rounded px-3 py-2"
                                               onchange="previewImage(event, 'previewImage3')" />
                                        <img id="previewImage3" class="mt-2 w-32 h-32 object-cover rounded"
                                             src="" style="display: none;" alt="Preview Ảnh phụ 2" />
                                    </div>
                                </div>
                                <div class="flex justify-end space-x-2 mt-4">
                                    <button type="submit" class="bg-primary text-white px-4 py-2 rounded">Thêm
                                        mới</button>
                                    <a href="${pageContext.request.contextPath}/FishManage"
                                       class="bg-gray-300 text-gray-700 px-4 py-2 rounded">Hủy</a>
                                </div>
                            </form>
                            <button
                                onclick="window.location.href = '${pageContext.request.contextPath}/FishManage'"
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
                                window.location.href = '${pageContext.request.contextPath}/FishManage?action=add';
                            });
                        }
                    });
                </script>
            </div>
        </div>
    </body>

</html>