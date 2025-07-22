<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bản Đồ Hồ Câu Nổi Tiếng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            /* Gradient nền đẹp mắt */
            background: linear-gradient(135deg, #e3f0ff 0%, #e9e9ff 50%, #c1e2fc 100%);
            min-height: 100vh;
        }
        .section-title {
            font-family: 'Segoe UI', 'Roboto', Arial, sans-serif;
            font-weight: bold;
            color: #2261ae;
            letter-spacing: 1px;
            font-size: 2.7rem;
        }
        .region-select {
            min-width: 200px;
            font-size: 1.15rem;
            border-radius: 8px;
            border: 1.5px solid #e2e8f0;
            background: #f1f5fb;
        }
        .map-container {
            max-width: 1200px;
            width: 96vw;
            margin: 0 auto;
            border-radius: 22px;
            box-shadow: 0 12px 40px rgba(36, 97, 174, 0.11), 0 1.5px 6px rgba(34,97,174,0.06);
            overflow: hidden;
            background: #fff;
            transition: box-shadow 0.3s;
        }
        .map-container:hover {
            box-shadow: 0 18px 52px rgba(36, 97, 174, 0.18), 0 2.5px 9px rgba(34,97,174,0.11);
        }
        @media (max-width: 1000px) {
            .map-container {
                max-width: 100vw;
            }
        }
    </style>
</head>
<body>
    <div class="py-5">
        <h1 class="section-title text-center mb-3">Bản Đồ Hồ Câu Nổi Tiếng</h1>
        <p class="text-center text-secondary mb-4 fs-5">
            Chọn khu vực để xem các hồ câu nổi tiếng từng vùng. Click vào từng điểm để xem chi tiết, hình ảnh, địa chỉ, số điện thoại từng hồ câu.
        </p>
        <div class="d-flex justify-content-center mb-4">
            <select id="regionSelect" class="region-select p-2 shadow-sm">
                <option value="north">Miền Bắc</option>
                <option value="central">Miền Trung</option>
                <option value="south">Miền Nam</option>
            </select>
        </div>
        <div class="map-container mb-4">
            <iframe id="mapFrame"
                src="https://www.google.com/maps/d/embed?mid=1XquqQHPtS_JiZkub598SuIJ1MtZ6vww&ehbc=2E312F"
                width="100%" height="650"
                style="border:0; display: block;"
                allowfullscreen="" loading="lazy"></iframe>
        </div>
    </div>
    <script>
        const regionUrls = {
            north: "https://www.google.com/maps/d/embed?mid=1XquqQHPtS_JiZkub598SuIJ1MtZ6vww&ehbc=2E312F",
            central: "https://www.google.com/maps/d/embed?mid=1tiEz5cB-MQF33fOA0vJ0BBPrZTU1HoY&ehbc=2E312F",
            south: "https://www.google.com/maps/d/embed?mid=1ewn6zkH3APdCZj9CrxSE86V6p5esxtQ&ehbc=2E312F"
        };

        document.getElementById('regionSelect').addEventListener('change', function () {
            var iframe = document.getElementById('mapFrame');
            var region = this.value;
            iframe.src = regionUrls[region];
        });
    </script>
</body>
</html>
