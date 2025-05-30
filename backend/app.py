from flask import Flask, jsonify, request
from flask_cors import CORS
from datetime import datetime, timedelta
import random

app = Flask(__name__)
CORS(app)  # Flutter Web과의 통신을 위한 CORS 설정

# 예시 데이터
vip_passes = [
    {
        "id": 1,
        "title": "융프라우 1일권",
        "price": 213020,
        "features": ["전 구간 무제한 이용", "전망대 입장 포함"]
    },
    {
        "id": 2,
        "title": "융프라우 3일권",
        "price": 583530,
        "features": ["3일간 무제한 이용", "특별 할인 혜택"]
    }
]

hotels = [
    {
        "id": 1,
        "name": "Hotel Derby Grindelwald",
        "location": "Grindelwald",
        "rating": 4.5,
        "price_per_night": 250000,
        "description": "그린델발트 중심에 위치한 4성급 호텔",
        "amenities": ["무료 WiFi", "조식 포함", "스파", "주차장"],
        "images": ["derby_1.jpg", "derby_2.jpg"]
    },
    {
        "id": 2,
        "name": "Metropole Hotel Interlaken",
        "location": "Interlaken",
        "rating": 4.8,
        "price_per_night": 350000,
        "description": "인터라켄의 럭셔리 호텔",
        "amenities": ["무료 WiFi", "미슐랭 레스토랑", "수영장", "피트니스 센터"],
        "images": ["metropole_1.jpg", "metropole_2.jpg"]
    }
]

train_schedules = [
    {
        "id": 1,
        "from": "인터라켄",
        "to": "융프라우요흐",
        "departure": "09:00",
        "arrival": "10:30",
        "price": 150000,
        "available_seats": 45
    },
    {
        "id": 2,
        "from": "그린델발트",
        "to": "융프라우요흐",
        "departure": "10:00",
        "arrival": "11:15",
        "price": 120000,
        "available_seats": 32
    }
]

weather_info = {
    "융프라우요흐": {"temp": -8, "condition": "맑음", "wind": 15},
    "그린델발트": {"temp": 12, "condition": "흐림", "wind": 5},
    "인터라켄": {"temp": 15, "condition": "맑음", "wind": 3}
}

# VIP 패스 API
@app.route('/api/vip-passes', methods=['GET'])
def get_vip_passes():
    return jsonify(vip_passes)

@app.route('/api/vip-passes/book', methods=['POST'])
def book_vip_pass():
    if not request.is_json:
        return jsonify({"error": "Content-Type must be application/json"}), 400
    
    booking_data = request.get_json()
    if not booking_data:
        return jsonify({"error": "No data provided"}), 400

    return jsonify({
        "message": "예약이 완료되었습니다.",
        "booking_id": f"JUNGFRAU-2024-{random.randint(1000, 9999)}",
        "data": booking_data
    })

# 호텔 API
@app.route('/api/hotels', methods=['GET'])
def get_hotels():
    return jsonify(hotels)

@app.route('/api/hotels/<int:hotel_id>/book', methods=['POST'])
def book_hotel(hotel_id):
    if not request.is_json:
        return jsonify({"error": "Content-Type must be application/json"}), 400
    
    booking_data = request.get_json()
    return jsonify({
        "message": "호텔 예약이 완료되었습니다.",
        "booking_id": f"HOTEL-2024-{random.randint(1000, 9999)}",
        "hotel_id": hotel_id,
        "data": booking_data
    })

# 기차 시간표 API
@app.route('/api/train-schedules', methods=['GET'])
def get_train_schedules():
    date = request.args.get('date', datetime.now().strftime('%Y-%m-%d'))
    return jsonify(train_schedules)

@app.route('/api/train-schedules/book', methods=['POST'])
def book_train():
    if not request.is_json:
        return jsonify({"error": "Content-Type must be application/json"}), 400
    
    booking_data = request.get_json()
    return jsonify({
        "message": "기차표 예약이 완료되었습니다.",
        "booking_id": f"TRAIN-2024-{random.randint(1000, 9999)}",
        "data": booking_data
    })

# 날씨 정보 API
@app.route('/api/weather', methods=['GET'])
def get_weather():
    location = request.args.get('location', '융프라우요흐')
    if location in weather_info:
        return jsonify(weather_info[location])
    return jsonify({"error": "Location not found"}), 404

if __name__ == '__main__':
    app.run(debug=True) 