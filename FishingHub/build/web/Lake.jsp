<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ page import="model.Users" %>
        <%@ page import="java.util.List" %>
            <%@ page import="model.FishingLake" %>
                <%@ page import="java.util.Map" %>
                    <%@ page import="java.util.HashMap" %>
                        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                            <%
    Users currentUser = (Users) session.getAttribute("user");
    List<FishingLake> lakes = (List<FishingLake>) request.getAttribute("lakes");
    if (currentUser == null || currentUser.getRoleId() != 2) {
        response.sendRedirect("Home.jsp");
        return;
    }


%>
                                <!DOCTYPE html>
                                <html lang="en">

                                <head>
                                    <meta charset="UTF-8">
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                    <title>Profile Chủ Hồ Câu</title>
                                    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
                                    <script>
                                        tailwind.config = {
                                            theme: {
                                                extend: {
                                                    colors: {
                                                        primary: '#1E88E5',
                                                        secondary: '#FFA726'
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
                                        }
                                    </script>
                                    <link rel="preconnect" href="https://fonts.googleapis.com">
                                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                                    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
                                    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
                                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
                                    <link rel="stylesheet" href="assets/css/style.css">
                                </head>

                                <body>
                                    <!-- Header -->
                                    <header class="bg-white shadow-sm">
                                        <div class="container mx-auto px-4 py-3 flex items-center justify-between">
                                            <div class="flex items-center">
                                                <a href="Home.jsp" class="text-3xl font-['Pacifico'] text-primary">FishingHub</a>
                                                <nav class="hidden md:flex ml-10">
                                                    <a href="Home.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Trang Chủ</a>
                                                    <a href="Event" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Sự Kiện</a>
                                                    <a href="NewFeed.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Bảng Tin</a>
                                                    <a href="Product.sprites" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Cửa Hàng</a>
                                                    <a href="KnowledgeFish" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Kiến Thức</a>
                                                    <a href="Achievement.jsp" class="px-4 py-2 text-gray-800 font-medium hover:text-primary">Xếp Hạng</a>
                                                </nav>
                                            </div>
                                            <div class="flex items-center space-x-4">
                                                <div class="relative w-10 h-10 flex items-center justify-center">
                                                    <button class="text-gray-700 hover:text-primary">
                            <i class="ri-shopping-cart-2-line text-xl"></i>
                        </button>
                                                    <span class="absolute -top-1 -right-1 bg-red-500 text-white text-xs w-5 h-5 flex items-center justify-center rounded-full">3</span>
                                                </div>
                                                <div class="relative">
                                                    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-100 cursor-pointer">
                                                        <i class="ri-notification-3-line text-gray-600"></i>
                                                    </div>
                                                    <span class="absolute -top-1 -right-1 flex h-5 w-5 items-center justify-center rounded-full bg-primary text-xs text-white">3</span>
                                                </div>
                                                <% if (currentUser == null) { %>
                                                    <a href="Login.jsp" class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap">Đăng Nhập</a>
                                                    <a href="Register.jsp" class="bg-white text-primary border border-primary px-4 py-2 rounded-button whitespace-nowrap">Đăng Ký</a>
                                                    <% } else { %>
                                                        <div class="flex items-center space-x-3">
                                                            <a href="LakeServlet" class="font-semibold text-primary hover:underline flex items-center">
                                                                <i class="ri-user-line mr-1"></i>
                                                                <%= currentUser.getFullName() %>
                                                            </a>
                                                            <a href="dashboard_owner/Dashboard.jsp" class="bg-secondary text-white px-4 py-2 rounded-button whitespace-nowrap hover:bg-secondary/90">Dashboard</a>
                                                            <form action="logout" method="post" style="display:inline;">
                                                                <button type="submit" class="bg-gray-200 text-gray-800 px-3 py-2 rounded-button hover:bg-gray-300">Đăng Xuất</button>
                                                            </form>
                                                        </div>
                                                        <% } %>
                                            </div>
                                        </div>
                                    </header>

                                    <!-- Profile Content -->
                                    <div class="container mx-auto px-4 py-8">
                                        <!-- User Information -->
                                        <div class="bg-white shadow-md rounded-lg p-6 mb-8 flex items-center justify-between">
                                            <div>
                                                <h1 class="text-3xl font-bold text-primary mb-2">
                                                    <%= currentUser.getFullName() %>
                                                </h1>
                                                <p class="text-gray-600"><i class="ri-map-pin-line mr-2"></i>Địa điểm:
                                                    <%= currentUser.getLocation() != null ? currentUser.getLocation() : "Chưa cập nhật" %>
                                                </p>
                                            </div>
                                            <button id="btn-create-lake" class="ml-4 bg-primary text-white px-4 py-2 rounded-button hover:bg-primary/90 flex items-center">
                    <i class="ri-add-line mr-1"></i> Tạo hồ câu mới
                </button>
                                        </div>
                                        <!-- Form tạo hồ câu mới (ẩn mặc định) -->
                                        <form id="create-lake-form" action="createLake" method="post" class="bg-white shadow-md rounded-lg p-6 mb-8 max-w-lg mx-auto hidden">
                                            <h2 class="text-xl font-bold text-primary mb-4">Tạo hồ câu mới</h2>
                                            <div class="mb-4">
                                                <label class="block mb-1 font-medium">Tên hồ câu</label>
                                                <input type="text" name="lakeName" class="w-full border rounded px-3 py-2" required />
                                            </div>
                                            <div class="mb-4">
                                                <label class="block mb-1 font-medium">Địa điểm</label>
                                                <div class="flex flex-col gap-2">
                                                    <select name="province" id="create-province" class="w-full border rounded px-3 py-2" required>
                            <option value="">Chọn Tỉnh/Thành</option>
                        </select>
                                                    <select name="district" id="create-district" class="w-full border rounded px-3 py-2" required disabled>
                            <option value="">Chọn Quận/Huyện</option>
                        </select>
                                                    <select name="ward" id="create-ward" class="w-full border rounded px-3 py-2" required disabled>
                            <option value="">Chọn Phường/Xã</option>
                        </select>
                                                </div>
                                            </div>
                                            <div class="flex justify-end gap-2">
                                                <button type="button" id="cancel-create-lake" class="px-4 py-2 rounded bg-gray-200 text-gray-800 hover:bg-gray-300">Hủy</button>
                                                <button type="submit" class="px-4 py-2 rounded bg-primary text-white hover:bg-primary/90">Tạo mới</button>
                                            </div>
                                        </form>

                                        <!-- Fishing Lakes -->
                                        <h2 class="text-2xl font-bold text-gray-800 mb-4">Các hồ câu đang quản lý</h2>
                                        <div class="flex flex-wrap gap-4 mb-8">
                                            <c:choose>
                                                <c:when test="${not empty lakes}">
                                                    <c:forEach var="lake" items="${lakes}">
                                                        <button class="lake-btn bg-primary text-white px-4 py-2 rounded-button hover:bg-primary/90 focus:outline-none" data-lake-id="${lake.lakeId}">
                                ${lake.name}
                            </button>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="text-gray-500">Hiện tại bạn chưa quản lý hồ câu nào.</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <!-- Render sẵn các block thông tin hồ, ẩn đi -->
                                        <c:forEach var="lake" items="${lakes}">
                                            <div id="lake-info-${lake.lakeId}" class="lake-info-block hidden">
                                                <div class="bg-white shadow-md rounded-lg p-6 mb-4">
                                                    <h3 class="text-xl font-semibold text-primary mb-2">${lake.name}</h3>
                                                    <p class="text-gray-600 mb-2"><i class="ri-map-pin-line mr-2"></i>Địa điểm: ${lake.location != null ? lake.location : 'Chưa cập nhật'}</p>
                                                    <div class="mb-2">
                                                        <span class="font-semibold">Loài cá trong hồ:</span>
                                                        <ul class="list-disc ml-6">
                                                            <c:choose>
                                                                <c:when test="${not empty lake.lakeFishInfoList}">
                                                                    <c:forEach var="info" items="${lake.lakeFishInfoList}">
                                                                        <li>${info.fishName} <span class="text-gray-500">Giá thu lại: <span class="fish-price-format">${info.price}</span> VND/kg</span>
                                                                        </li>
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li>Chưa có dữ liệu</li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </ul>
                                                    </div>
                                                    <div class="flex gap-3 mt-4">
                                                        <button class="flex items-center px-3 py-2 bg-green-500 text-white rounded-button hover:bg-green-600" title="Cập nhật loài cá" onclick="document.getElementById('update-fish-modal-${lake.lakeId}').classList.remove('hidden')">
                                <i class="ri-refresh-line mr-1"></i> Cập nhật loài cá
                            </button>
                                                        <button class="flex items-center px-3 py-2 bg-yellow-500 text-white rounded-button hover:bg-yellow-600" title="Sửa thông tin hồ" onclick="openEditLakeModal('${lake.lakeId}', '${lake.name}', '${lake.location}')">
                                <i class="ri-edit-2-line mr-1"></i> Sửa hồ
                            </button>
                                                        <button class="flex items-center px-3 py-2 bg-red-500 text-white rounded-button hover:bg-red-600" title="Xóa hồ" onclick="openDeleteLakeModal('${lake.lakeId}', '${lake.name}')">
                                <i class="ri-delete-bin-6-line mr-1"></i> Xóa hồ
                            </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div id="lake-info-container"></div>
                                    </div>

                                    <!-- Modal Thêm cá -->
                                    <div id="add-fish-modal" class="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center z-50 hidden">
                                        <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md">
                                            <h3 class="text-lg font-bold mb-4">Thêm loài cá vào hồ <span id="add-fish-lake-name"></span></h3>
                                            <form id="add-fish-form" method="post" action="addFishToLake">
                                                <input type="hidden" name="lakeId" id="add-fish-lake-id" />
                                                <div id="add-fish-list" class="mb-4">
                                                    <c:forEach var="fish" items="${lake.fishSpeciesNotInLake}">
                                                        <c:set var="addDisplayStyle" value="none" />
                                                        <label class="flex items-center mb-1">
                                <input type="checkbox" name="fishSpeciesIds" value="${fish.id}" class="mr-2 add-fish-checkbox" onchange="toggleFishPriceInput(this)" />
                                <span>${fish.commonName}</span>
                                <input type="number" name="fishPrices" placeholder="Giá (VND/kg)" class="ml-2 border rounded px-2 py-1 w-28 fish-price-input" min="1000" step="1000" style="display: ${addDisplayStyle};" />
                                <span class="ml-1 text-xs text-gray-500">VND/kg</span>
                            </label>
                                                    </c:forEach>
                                                </div>
                                                <div class="flex justify-end gap-2">
                                                    <button type="button" onclick="closeAddFishModal()" class="px-4 py-2 rounded bg-gray-200 text-gray-800 hover:bg-gray-300">Hủy</button>
                                                    <button type="submit" class="px-4 py-2 rounded bg-green-500 text-white hover:bg-green-600">Thêm</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <c:if test="${not empty lakes}">
                                        <c:forEach var="lake" items="${lakes}">
                                            <div id="fish-list-not-in-lake-${lake.lakeId}" class="hidden">
                                                <c:choose>
                                                    <c:when test="${not empty lake.fishSpeciesNotInLake}">
                                                        <c:forEach var="fish" items="${lake.fishSpeciesNotInLake}">
                                                            <label class="flex items-center mb-1">
                                    <input type="checkbox" name="fishSpeciesIds" value="${fish.id}" class="mr-2" />
                                    <span>${fish.commonName}</span>
                                    <input type="number" name="fishPrices" placeholder="Giá (VNĐ)" class="ml-2 border rounded px-2 py-1 w-24" min="0" step="1000" required />
                                </label>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-gray-500">Tất cả loài cá đã có trong hồ này.</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:forEach>
                                    </c:if>

                                    <!-- Modal Sửa hồ -->
                                    <div id="edit-lake-modal" class="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center z-50 hidden">
                                        <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md">
                                            <h3 class="text-lg font-bold mb-4">Sửa thông tin hồ <span id="edit-lake-name"></span></h3>
                                            <form id="edit-lake-form" method="post" action="editLake">
                                                <input type="hidden" name="lakeId" id="edit-lake-id" />
                                                <div class="mb-4">
                                                    <label class="block mb-1 font-medium">Tên hồ câu</label>
                                                    <input type="text" name="lakeName" id="edit-lake-name-input" class="w-full border rounded px-3 py-2" required />
                                                </div>
                                                <div class="mb-4">
                                                    <label class="block mb-1 font-medium">Địa điểm</label>
                                                    <div class="flex flex-col gap-2">
                                                        <select name="province" id="edit-province" class="w-full border rounded px-3 py-2" required>
                                <option value="">Chọn Tỉnh/Thành</option>
                            </select>
                                                        <select name="district" id="edit-district" class="w-full border rounded px-3 py-2" required disabled>
                                <option value="">Chọn Quận/Huyện</option>
                            </select>
                                                        <select name="ward" id="edit-ward" class="w-full border rounded px-3 py-2" required disabled>
                                <option value="">Chọn Phường/Xã</option>
                            </select>
                                                    </div>
                                                </div>
                                                <div class="flex justify-end gap-2">
                                                    <button type="button" onclick="closeEditLakeModal()" class="px-4 py-2 rounded bg-gray-200 text-gray-800 hover:bg-gray-300">Hủy</button>
                                                    <button type="submit" class="px-4 py-2 rounded bg-yellow-500 text-white hover:bg-yellow-600">Lưu</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- Modal Xóa hồ -->
                                    <div id="delete-lake-modal" class="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center z-50 hidden">
                                        <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-sm">
                                            <h3 class="text-lg font-bold mb-4 text-red-600">Xác nhận xóa hồ</h3>
                                            <p>Bạn có chắc muốn xóa hồ <span id="delete-lake-name"></span> không?</p>
                                            <form id="delete-lake-form" method="post" action="deleteLake">
                                                <input type="hidden" name="lakeId" id="delete-lake-id" />
                                                <div class="flex justify-end gap-2 mt-4">
                                                    <button type="button" onclick="closeDeleteLakeModal()" class="px-4 py-2 rounded bg-gray-200 text-gray-800 hover:bg-gray-300">Hủy</button>
                                                    <button type="submit" class="px-4 py-2 rounded bg-red-500 text-white hover:bg-red-600">Xóa</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- Render tất cả modal cập nhật loài cá cho từng hồ ở cuối file -->
                                    <c:forEach var="lake" items="${lakes}">
                                        <div id="update-fish-modal-${lake.lakeId}" class="fixed inset-0 bg-black bg-opacity-30 flex items-center justify-center z-50 hidden">
                                            <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md">
                                                <h3 class="text-lg font-bold mb-4">Cập nhật loài cá cho hồ <span>${lake.name}</span></h3>
                                                <form method="post" action="updateLakeFish">
                                                    <input type="hidden" name="lakeId" value="${lake.lakeId}" />
                                                    <div class="mb-4">
                                                        <c:forEach var="fish" items="${fishSpeciesList}">
                                                            <c:set var="fishPrice" value="" />
                                                            <c:set var="isChecked" value="false" />
                                                            <c:forEach var="info" items="${lake.lakeFishInfoList}">
                                                                <c:if test="${info.fishSpeciesId == fish.id}">
                                                                    <c:set var="fishPrice" value="${info.price}" />
                                                                    <c:set var="isChecked" value="true" />
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:set var="displayStyle" value="${isChecked ? 'block' : 'none'}" />
                                                            <label class="flex items-center mb-1">
                                    <input type="checkbox" name="fishSpeciesIds" value="${fish.id}" class="mr-2 update-fish-checkbox" <c:if test="${isChecked}">checked</c:if> onchange="toggleFishPriceInput(this)" />
                                    <span>${fish.commonName}</span>
                                    <input type="number" name="fishPrices_${fish.id}" placeholder="Giá (VND/kg)" class="ml-2 border rounded px-2 py-1 w-28 fish-price-input" min="1000" step="1000" style="display: ${displayStyle};" value="${fishPrice}" />
                                    <span class="ml-1 text-xs text-gray-500">VND/kg</span>
                                </label>
                                                        </c:forEach>
                                                    </div>
                                                    <div class="flex justify-end gap-2">
                                                        <button type="button" onclick="document.getElementById('update-fish-modal-${lake.lakeId}').classList.add('hidden')" class="px-4 py-2 rounded bg-gray-200 text-gray-800 hover:bg-gray-300">Hủy</button>
                                                        <button type="submit" class="px-4 py-2 rounded bg-green-500 text-white hover:bg-green-600">Cập nhật</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <script>
                                        document.getElementById('btn-create-lake').onclick = function() {
                                            document.getElementById('create-lake-form').classList.remove('hidden');
                                        };
                                        document.getElementById('cancel-create-lake').onclick = function() {
                                            document.getElementById('create-lake-form').classList.add('hidden');
                                        };

                                        document.querySelectorAll('.lake-btn').forEach(function(btn) {
                                            btn.addEventListener('click', function() {
                                                document.querySelectorAll('.lake-info-block').forEach(function(div) {
                                                    div.classList.add('hidden');
                                                });
                                                var lakeId = btn.getAttribute('data-lake-id');
                                                var infoDiv = document.getElementById('lake-info-' + lakeId);
                                                if (infoDiv) {
                                                    document.getElementById('lake-info-container').innerHTML = infoDiv.innerHTML;
                                                }
                                            });
                                        });

                                        function openAddFishModal(lakeId, lakeName) {
                                            document.getElementById('add-fish-lake-id').value = lakeId;
                                            document.getElementById('add-fish-lake-name').innerText = lakeName;
                                            var fishListDiv = document.getElementById('fish-list-not-in-lake-' + lakeId);
                                            document.getElementById('add-fish-list').innerHTML = fishListDiv ? fishListDiv.innerHTML : '<span class="text-gray-500">Không có dữ liệu</span>';
                                            document.getElementById('add-fish-modal').classList.remove('hidden');
                                        }

                                        function closeAddFishModal() {
                                            document.getElementById('add-fish-modal').classList.add('hidden');
                                        }

                                        function openEditLakeModal(lakeId, lakeName, lakeLocation) {
                                            document.getElementById('edit-lake-id').value = lakeId;
                                            document.getElementById('edit-lake-name').innerText = lakeName;
                                            document.getElementById('edit-lake-name-input').value = lakeName;
                                            document.getElementById('edit-lake-modal').classList.remove('hidden');
                                        }

                                        function closeEditLakeModal() {
                                            document.getElementById('edit-lake-modal').classList.add('hidden');
                                        }

                                        function openDeleteLakeModal(lakeId, lakeName) {
                                            document.getElementById('delete-lake-id').value = lakeId;
                                            document.getElementById('delete-lake-name').innerText = lakeName;
                                            document.getElementById('delete-lake-modal').classList.remove('hidden');
                                        }

                                        function closeDeleteLakeModal() {
                                            document.getElementById('delete-lake-modal').classList.add('hidden');
                                        }

                                        function toggleFishPriceInput(checkbox) {
                                            var priceInput = checkbox.parentElement.querySelector('.fish-price-input');
                                            if (checkbox.checked) {
                                                priceInput.style.display = '';
                                                priceInput.required = true;
                                                priceInput.disabled = false;
                                            } else {
                                                priceInput.style.display = 'none';
                                                priceInput.required = false;
                                                priceInput.disabled = false;
                                                priceInput.value = '';
                                            }
                                        }

                                        document.addEventListener("DOMContentLoaded", function() {
                                            function loadProvinces(selectElement) {
                                                fetch("https://provinces.open-api.vn/api/p/")
                                                    .then(response => response.json())
                                                    .then(data => {
                                                        selectElement.innerHTML = '<option value="">Chọn Tỉnh/Thành</option>';
                                                        data.forEach(province => {
                                                            let option = document.createElement("option");
                                                            option.value = province.code;
                                                            option.textContent = province.name;
                                                            selectElement.appendChild(option);
                                                        });
                                                    })
                                                    .catch(error => console.error("❌ Lỗi khi tải danh sách tỉnh/thành:", error));
                                            }

                                            function loadDistricts(provinceCode, districtSelect, wardSelect) {
                                                if (!provinceCode) return;
                                                districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';
                                                wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';
                                                districtSelect.disabled = true;
                                                wardSelect.disabled = true;
                                                let apiUrl = "https://provinces.open-api.vn/api/p/" + provinceCode + "?depth=2";
                                                fetch(apiUrl)
                                                    .then(response => response.json())
                                                    .then(data => {
                                                        data.districts.forEach(district => {
                                                            let option = document.createElement("option");
                                                            option.value = district.code;
                                                            option.textContent = district.name;
                                                            districtSelect.appendChild(option);
                                                        });
                                                        districtSelect.disabled = false;
                                                    })
                                                    .catch(error => console.error("❌ Lỗi khi tải danh sách quận/huyện:", error));
                                            }

                                            function loadWards(districtCode, wardSelect) {
                                                if (!districtCode) return;
                                                wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';
                                                wardSelect.disabled = true;
                                                let apiUrl = "https://provinces.open-api.vn/api/d/" + districtCode + "?depth=2";
                                                fetch(apiUrl)
                                                    .then(response => response.json())
                                                    .then(data => {
                                                        data.wards.forEach(ward => {
                                                            let option = document.createElement("option");
                                                            option.value = ward.code;
                                                            option.textContent = ward.name;
                                                            wardSelect.appendChild(option);
                                                        });
                                                        wardSelect.disabled = false;
                                                    })
                                                    .catch(error => console.error("❌ Lỗi khi tải danh sách phường/xã:", error));
                                            }

                                            const createProvinceSelect = document.getElementById("create-province");
                                            const createDistrictSelect = document.getElementById("create-district");
                                            const createWardSelect = document.getElementById("create-ward");

                                            loadProvinces(createProvinceSelect);

                                            createProvinceSelect.addEventListener("change", function() {
                                                let provinceCode = this.value;
                                                loadDistricts(provinceCode, createDistrictSelect, createWardSelect);
                                            });

                                            createDistrictSelect.addEventListener("change", function() {
                                                let districtCode = this.value;
                                                loadWards(districtCode, createWardSelect);
                                            });

                                            const editProvinceSelect = document.getElementById("edit-province");
                                            const editDistrictSelect = document.getElementById("edit-district");
                                            const editWardSelect = document.getElementById("edit-ward");

                                            loadProvinces(editProvinceSelect);

                                            editProvinceSelect.addEventListener("change", function() {
                                                let provinceCode = this.value;
                                                loadDistricts(provinceCode, editDistrictSelect, editWardSelect);
                                            });

                                            editDistrictSelect.addEventListener("change", function() {
                                                let districtCode = this.value;
                                                loadWards(districtCode, editWardSelect);
                                            });
                                        });

                                        const createLakeForm = document.getElementById('create-lake-form');
                                        if (createLakeForm) {
                                            createLakeForm.addEventListener('submit', function(e) {
                                                const provinceSelect = document.getElementById('create-province');
                                                const districtSelect = document.getElementById('create-district');
                                                const wardSelect = document.getElementById('create-ward');
                                                const provinceName = provinceSelect.options[provinceSelect.selectedIndex].textContent;
                                                const districtName = districtSelect.options[districtSelect.selectedIndex].textContent;
                                                const wardName = wardSelect.options[wardSelect.selectedIndex].textContent;
                                                const fullLocation = wardName + ', ' + districtName + ', ' + provinceName;
                                                let hiddenInput = document.createElement('input');
                                                hiddenInput.type = 'hidden';
                                                hiddenInput.name = 'lakeLocation';
                                                hiddenInput.value = fullLocation;
                                                createLakeForm.appendChild(hiddenInput);
                                            });
                                        }

                                        const editLakeForm = document.getElementById('edit-lake-form');
                                        if (editLakeForm) {
                                            editLakeForm.addEventListener('submit', function(e) {
                                                const provinceSelect = document.getElementById('edit-province');
                                                const districtSelect = document.getElementById('edit-district');
                                                const wardSelect = document.getElementById('edit-ward');
                                                const provinceName = provinceSelect.options[provinceSelect.selectedIndex].textContent;
                                                const districtName = districtSelect.options[districtSelect.selectedIndex].textContent;
                                                const wardName = wardSelect.options[wardSelect.selectedIndex].textContent;
                                                const fullLocation = wardName + ', ' + districtName + ', ' + provinceName;
                                                let hiddenInput = document.createElement('input');
                                                hiddenInput.type = 'hidden';
                                                hiddenInput.name = 'lakeLocation';
                                                hiddenInput.value = fullLocation;
                                                editLakeForm.appendChild(hiddenInput);
                                            });
                                        }

                                        function toggleFishPriceInput(checkbox) {
                                            var priceInput = checkbox.parentElement.querySelector('.fish-price-input');
                                            if (checkbox.checked) {
                                                priceInput.style.display = '';
                                                priceInput.required = true;
                                                priceInput.disabled = false;
                                            } else {
                                                priceInput.style.display = 'none';
                                                priceInput.required = false;
                                                priceInput.disabled = false;
                                                priceInput.value = '';
                                            }
                                        }

                                        // Đảm bảo chỉ required giá khi checkbox được chọn (cập nhật cá)
                                        document.querySelectorAll('#update-fish-list .update-fish-checkbox').forEach(function(checkbox) {
                                            checkbox.addEventListener('change', function() {
                                                var priceInput = this.parentElement.querySelector('input[type="number"]');
                                                var hasPrice = this.getAttribute('data-has-price') === 'true';
                                                if (this.checked) {
                                                    priceInput.style.display = '';
                                                    priceInput.disabled = false;
                                                    priceInput.required = true;
                                                } else {
                                                    priceInput.style.display = 'none';
                                                    priceInput.required = false;
                                                    priceInput.disabled = false;
                                                    priceInput.value = '';
                                                }
                                            });
                                        });

                                        // Format giá tiền VND (1.000, 30.000)
                                        function formatVND(num) {
                                            if (typeof num === 'string') {
                                                num = num.replace(/[^\d.\-]/g, ''); // loại bỏ ký tự không phải số
                                            }
                                            let n = Number(num);
                                            if (!n || isNaN(n) || n <= 0) return '0';
                                            return Math.round(n).toLocaleString('vi-VN');
                                        }
                                        document.addEventListener('DOMContentLoaded', function() {
                                            document.querySelectorAll('.fish-price-format').forEach(function(span) {
                                                span.textContent = formatVND(span.textContent);
                                            });

                                            // Validate giá > 1000 khi submit form thêm/cập nhật cá
                                            function validateFishPrice(formId) {
                                                const form = document.getElementById(formId);
                                                if (!form) return;
                                                form.addEventListener('submit', function(e) {
                                                    let valid = true;
                                                    let firstInvalid = null;
                                                    form.querySelectorAll('input[type="checkbox"]:checked').forEach(function(cb) {
                                                        const priceInput = cb.parentElement.querySelector('input[type="number"]');
                                                        if (!priceInput || Number(priceInput.value) < 1000) {
                                                            valid = false;
                                                            priceInput.classList.add('border-red-500');
                                                            if (!firstInvalid) firstInvalid = priceInput;
                                                        } else {
                                                            priceInput.classList.remove('border-red-500');
                                                        }
                                                    });
                                                    if (!valid) {
                                                        e.preventDefault();
                                                        alert('Giá tiền phải lớn hơn hoặc bằng 1.000 VND/kg cho mỗi loài cá!');
                                                        if (firstInvalid) firstInvalid.focus();
                                                    }
                                                });
                                            }

                                            validateFishPrice('add-fish-form');
                                            validateFishPrice('update-fish-form');
                                        });
                                    </script>
                                </body>

                                </html>