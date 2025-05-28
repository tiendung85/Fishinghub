<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh Sách Loài Cá</title>
        <script src="https://cdn.tailwindcss.com/3.4.16"></script>
        <script>tailwind.config = {theme: {extend: {colors: {primary: '#3b82f6', secondary: '#10b981'}, borderRadius: {'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'}}}}</script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" rel="stylesheet">
       <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="Header.jsp" />
        <!-- Breadcrumb -->
        <div class="bg-white border-b">
            <div class="container mx-auto px-4 py-3">
                <div class="flex items-center text-sm">
                    <a href="Home.jsp" class="text-gray-500 hover:text-primary">Trang Chủ</a>
                    <span class="mx-2 text-gray-400">/</span>
                    <span class="text-primary font-medium">Kiến Thức</span>
                </div>
            </div>
        </div>

        <main class="container mx-auto px-4 py-8">
            <div id="fishList" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                <c:choose>
                    <c:when test="${not empty fishList}">
                        <c:forEach var="fish" items="${fishList}">
                            <div class="card-fish bg-white rounded-lg shadow overflow-hidden">
                                <div class="relative aspect-square w-full">
                                    <img src="${fish.imageUrl}" alt="${fish.commonName}" class="w-full h-full object-cover object-center">
                                </div>
                                <div class="p-4">
                                    <h3 class="font-bold text-gray-800 text-lg mb-1">${fish.commonName}</h3>
                                    <p class="text-sm text-gray-600 mb-2"><i class="ri-map-pin-line mr-1"></i> ${fish.fishingSpots}</p>
                                    <div class="flex items-center space-x-2 mb-4">
                                        <span class="text-xs text-gray-500">Độ Khó:</span>
                                        <span class="text-xs font-semibold text-primary">${fish.difficultyLevel}</span>
                                    </div>
                                    <div class="flex justify-end">
                                        <a href="FishDetails?id=${fish.id}"
                                           class="inline-block px-4 py-1 border border-primary text-primary rounded-button text-sm hover:bg-primary hover:text-white transition-colors">
                                            Chi Tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-span-4 text-center text-gray-500">Không tìm thấy loài cá nào.</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="mt-10 flex justify-center">
                <nav class="flex items-center space-x-1">
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm" ${currentPage == 1 ? 'disabled' : ''} onclick="window.location.href='KnowledgeFish?page=${currentPage - 1}'">
                        <i class="ri-arrow-left-s-line"></i>
                    </button>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm ${currentPage == i ? 'active bg-primary text-white' : ''}"
                                onclick="window.location.href='KnowledgeFish?page=${i}'">${i}</button>
                    </c:forEach>
                    <button class="pagination-btn w-8 h-8 flex items-center justify-center rounded text-gray-600 text-sm" ${currentPage == totalPages ? 'disabled' : ''} onclick="window.location.href='KnowledgeFish?page=${currentPage + 1}'">
                        <i class="ri-arrow-right-s-line"></i>
                    </button>
                </nav>
            </div>
        </main>
        <button id="backToTop" class="back-to-top fixed bottom-6 right-6 w-12 h-12 bg-primary text-white rounded-full shadow-lg flex items-center justify-center">
            <i class="ri-arrow-up-line text-xl"></i>
        </button>
        <!-- Details Modal -->
        <div id="fishDetailModal" class="modal hidden fixed inset-0 z-50 overflow-auto bg-black bg-opacity-50 flex items-center justify-center">
            <div class="bg-white w-full max-w-4xl rounded-lg shadow-xl mx-4 overflow-hidden">
                <div class="relative">
                    <div class="h-64 md:h-80 bg-gray-100">
                        <img id="modalFishImage" src="" alt="" class="w-full h-full object-cover object-top">
                    </div>
                    <button id="closeModal" class="absolute top-4 right-4 w-10 h-10 flex items-center justify-center bg-white bg-opacity-70 rounded-full text-gray-700 hover:bg-opacity-100">
                        <i class="ri-close-line text-xl"></i>
                    </button>
                    <div class="absolute top-4 left-4 flex space-x-2">
                        <button id="modalBookmarkBtn" class="w-10 h-10 flex items-center justify-center bg-white bg-opacity-70 rounded-full text-gray-700 hover:bg-opacity-100">
                            <i class="ri-bookmark-line text-xl"></i>
                        </button>
                        <button id="modalShareBtn" class="w-10 h-10 flex items-center justify-center bg-white bg-opacity-70 rounded-full text-gray-700 hover:bg-opacity-100">
                            <i class="ri-share-line text-xl"></i>
                        </button>
                    </div>
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-4">
                        <div>
                            <h2 id="modalFishName" class="text-2xl font-bold text-gray-800">Cá Chép</h2>
                            <p id="modalFishScientificName" class="text-lg text-gray-600 italic">Cyprinus carpio</p>
                        </div>
                        <div id="modalFishEnvironment" class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm">Nước Ngọt</div>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div class="md:col-span-1">
                            <h3 class="text-lg font-semibold text-gray-800 mb-3">Phân Loại</h3>
                            <ul class="space-y-2 text-sm">
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Ngành:</span>
                                    <span id="modalFishPhylum" class="text-gray-800">Chordata</span>
                                </li>
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Lớp:</span>
                                    <span id="modalFishClass" class="text-gray-800">Actinopterygii</span>
                                </li>
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Bộ:</span>
                                    <span id="modalFishOrder" class="text-gray-800">Cypriniformes</span>
                                </li>
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Họ:</span>
                                    <span id="modalFishFamily" class="text-gray-800">Cyprinidae</span>
                                </li>
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Chi:</span>
                                    <span id="modalFishGenus" class="text-gray-800">Cyprinus</span>
                                </li>
                                <li class="flex">
                                    <span class="w-24 text-gray-500">Loài:</span>
                                    <span id="modalFishSpecies" class="text-gray-800">C. carpio</span>
                                </li>
                            </ul>
                            <h3 class="text-lg font-semibold text-gray-800 mt-6 mb-3">Phân Bố Địa Lý</h3>
                            <p id="modalFishDistribution" class="text-sm text-gray-700">Cá chép có nguồn gốc từ châu Á nhưng đã được du nhập vào nhiều quốc gia trên thế giới. Hiện nay, loài này phân bố rộng rãi ở các vùng nước ngọt trên khắp châu Á, châu Âu, châu Mỹ và châu Úc.</p>
                        </div>
                        <div class="md:col-span-2">
                            <h3 class="text-lg font-semibold text-gray-800 mb-3">Đặc Điểm Nhận Dạng</h3>
                            <p id="modalFishIdentification" class="text-sm text-gray-700 mb-4">Cá chép có thân dài, hơi dẹp bên. Đầu nhỏ với hai đôi râu ở môi trên. Vảy lớn, thường có màu đồng hoặc nâu đỏ, đôi khi có ánh đỏ tùy thuộc vào môi trường sống. Vây lưng dài với gai cứng ở phía trước. Cá chép có thể phát triển to, đạt trọng lượng lên đến 20kg và chiều dài đến 1m.</p>
                            
                            <h3 class="text-lg font-semibold text-gray-800 mb-3">Sinh Thái Học</h3>
                            <p id="modalFishEcology" class="text-sm text-gray-700 mb-4">Cá chép là loài cá nước ngọt, sống ở các vùng nước tĩnh hoặc chảy chậm như ao, hồ, đầm lầy, ruộng lúa và sông. Chúng thích nghi tốt với nhiều điều kiện môi trường và có thể sống sót trong nhiệt độ nước từ 3-35°C. Chúng là loài ăn tạp, chủ yếu ăn động vật không xương sống đáy, thực vật thủy sinh và các mảnh vụn hữu cơ. Tuổi thọ trung bình từ 15-20 năm, nhưng có thể sống đến 50 năm trong điều kiện thuận lợi.</p>

                            <h3 class="text-lg font-semibold text-gray-800 mb-3">Giá Trị Kinh Tế</h3>
                            <p id="modalFishEconomicValue" class="text-sm text-gray-700">Cá chép là một trong những loài cá nước ngọt được nuôi trồng phổ biến nhất trên toàn cầu. Thịt có hương vị thơm ngon và giàu dinh dưỡng, được sử dụng trong nhiều món ăn truyền thống. Ngoài giá trị thực phẩm, cá chép Koi - một giống cá chép Nhật Bản có màu sắc rực rỡ - còn được nuôi làm cảnh với giá trị kinh tế cao. Cá chép cũng được sử dụng trong các hệ thống canh tác tổng hợp, như mô hình VAC (Vườn-Ao-Chuồng) ở Việt Nam.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>