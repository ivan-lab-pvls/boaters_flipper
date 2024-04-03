import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/boat_model/boat_model.dart';
import 'models/news_model/news_model.dart';

class DataManager {
  static const _prefsKey = 'boatList';

  static List<BoatModel> boatModelsList = [];

  static Future<List<BoatModel>> loadBoatList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      boatModelsList =
          jsonList.map((item) => BoatModel.fromJson(item)).toList();
      return boatModelsList;
    }
    return [];
  }

  static Future<void> saveBoatList(List<BoatModel> boatList) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        boatList.map((item) => item.toJson()).toList();
    prefs.setString(_prefsKey, json.encode(jsonList));
  }

  static Future<void> addBoatToList(BoatModel boat) async {
    final boatList = await loadBoatList();
    boatList.add(boat);
    await saveBoatList(boatList);
  }

  static Future<void> removeBoatFromList(BoatModel boat) async {
    final boatList = await loadBoatList();

    boatList.removeWhere(
        (item) => item.whoRents == boat.whoRents && item.type == boat.type);
    boatModelsList.remove(boat);
    await saveBoatList(boatList);
  }

  static List<NewsModel> getAllNews() {
    List<NewsModel> news = [
      NewsModel(
          // Выбери соответствующую категорию
          date: getRandomDate(),
          imgUrl: "https://www.fraseryachts.com/uploads/image/SILVER_EDGE.jpg",
          title: "MOTOR YACHT FOR SALE NONNI II",
          body:
              "Award winning NONNI II (ex SEA FORCE ONE) is an iconic, head-turning yacht inside and out. She set a new benchmark in superyacht design upon her launch in 2008. Her spectacular design by the renowned Luca Dini, working in collaboration with CNL, earned her a Judges' Special Commendation at the 2009 World Superyacht Awards as Best Displacement Yacht in her category. The yacht’s striking profile and stunning exterior lines are complemented by a uniquely styled interior in which vibrant colours, sophisticated LED lighting and top-range audiovisual systems throughout draw guests into an entirely new world of electrical entertainment. Guest entertainment options abound on board NONNI II, including one of the best cinemas seen on any yacht and a huge nightclub with DJ booth and bar. The sundeck offers a hot tub, oversized sunpads and night-lit bar plus a Teppanyaki grill. Generous interior spaces bring the outside in, via floor-to-ceiling doors, skylights and balconies. Accommodation is in 5 suites, including an Owner’s stateroom with balcony and four suites on the lower deck, each with a different colour theme. Refitted in 2018 and 2023, NONNI II conforms to the ABS standards."),
      NewsModel(
        // Выбери соответствующую категорию
        date: getRandomDate(),
        imgUrl:
            'https://www.oceancoyacht.com/wp-content/uploads/23-020-MVD_AEOLUS_CAM_034_sunset_F.jpg',
        title: "MOTOR YACHT FOR SALE ZAMBOANGA",
        body:
            'ZAMBOANGA is a fine example of the very successful Leopard 27 series offering sleek lines and impressive speeds, reaching a maximum speed of 37 knots. She has been very well maintained by a full-time professional crew throughout her life and has only had one sole Owner since new, and only ever used privately. She features silver Awlgrip paint and a unique, modern interior which accommodates six guests in three staterooms. Offered VAT paid, she is ready for a new Owner.',
      ),
      NewsModel(
        // Выбери соответствующую категорию
        date: getRandomDate(),
        imgUrl:
            "https://alliedyachting.com/wp-content/uploads/2021/02/second-hand-yachts-for-sale-cannes-Mangusta-16-1030x618.jpg",
        title: "SAILING YACHT FOR SALE ELLEN",
        body: 'ELLEN is a 40-meter sailing yacht for sale delivered in 2001 by Perini Navi. She underwent an extensive 3-year refit and is restored to her original glory.  Meticulously maintained, ELLEN is presented on the market in impeccable condition. MCA-compliant and in Class (ABS), ELLEN is equipped with twin main engines and can reach a top speed of 12 knots. Combining comfort and elegance, with spacious interiors and decks, ELLEN can accommodate eight guests in four well-appointed staterooms.  She offers a clever layout rarely found on a 40-meter sailing yacht. VAT Paid, ELLEN also presents her future Owner with excellent charter market potential if desired.',
      ),
      NewsModel(
        // Выбери соответствующую категорию
        date: getRandomDate(),
        imgUrl:
            'https://www.travelandleisure.com/thmb/QEPCzG1U8DcFKAjkAq3OwIHmKp0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/somnio-yacht-exterior-night-ELEVATETOUT1221-6909011baaf042d3880ff18e2e04db8d.jpg',
        title: 'MOTOR YACHT FOR SALE FIRST ELEMENT',
        body: 'FIRST ELEMENT (22M/72’) is a yacht for sale, part of the Galeon 680 FLY lines. Delivered in 2001, she’s built with precision using advanced carbon fiber technology. Propelled by 2x MAN 1200 HP engines, FIRST ELEMENT can cruise at 18 knots and up to 32 knots. The main salon beckons with panoramic views, creating an ambiance of openness and serenity. Seamlessly transitioning to the exterior, large patio doors lead to the rear cockpit, perfect for al fresco dining experiences. The expansive flybridge, complete with a bar and grill area, offers the ideal setting for entertaining under the open sky. At the stern, a generous horseshoe seating area accommodates up to 12 guests comfortably, ensuring memorable gatherings with friends and family. Accommodating up to 8 guests across 4 staterooms, she is complete with an Owner\'s stateroom with a spacious layout and walkaround space, a double and two twin staterooms, all located on the Lower deck.',
      ),
      NewsModel(
        // Выбери соответствующую категорию
        date: getRandomDate(),
        imgUrl:
            'https://image.yachtcharterfleet.com/w1277/h618/qh/ca/m2/k467985e7/vessel/resource/2202543/charter-arrow-yacht.jpg',
        title: 'MOTOR YACHT FOR SALE STARLIGHT',
        body: 'Introducing yacht for sale STARLIGHT, a stunning 106’/32M motor yacht designed by C. Raymond Hunt and crafted at Goetz Custom Technologies. Renowned for her classic style and efficient design, STARLIGHT boasts a high gloss teak transom, expansive teak decks, and dark green topsides. This remarkable vessel has been family-cruised between New England, the Palm Beaches, and The Bahamas, and represents a unique offering on today’s market. The enclosed aft deck of STARLIGHT is a masterpiece of design and comfort. Featuring a beautifully finished "greenhouse" design with high gloss teak trim, this space offers versatility with stern windows that can be opened for an open-air ambiance or closed for protection from the elements. Equipped with a flat-screen Samsung TV, dining table, and custom cabinetry with essential amenities, the aft deck is ideal for dining or socializing in any weather condition. The main salon is beautifully finished with raised panel Mahogany interior joinery. With ample natural light streaming through large windows and newly installed blinds and curtains, the salon provides a serene atmosphere for relaxation and social gatherings. Below deck, STARLIGHT offers luxurious accommodations for up to 6 guests in 3 staterooms. The full-beam master stateroom impresses with a king-size bed, oversized cedar-lined walk-in closet, and a large ensuite bathroom. Two additional guest staterooms, each with their own ensuite, provide additional comfort and privacy for family and friends. In the pilothouse, state-of-the-art electronics ensure safe and efficient navigation. With redundant controls, multiple cameras, and advanced monitoring systems, the pilothouse is equipped for extended cruising in any conditions. The raised sitting area with a settee and table offers a comfortable space for guests to enjoy the journey. Ascending to the flybridge, guests are greeted by a newly replaced teak deck and a custom dining area for twelve guests. Complete with an outdoor kitchen, LED lighting, and a LYNX 42” propane BBQ, the flybridge is perfect for entertaining and enjoying panoramic views of the surrounding seascape. Boasting a remarkable fuel capacity and efficient design, STARLIGHT’s cruising capabilities are facilitated by five fuel tanks and transfer system for trim balancing. With her exquisite wood interiors, refinished teak decks, and classic lines, STARLIGHT embodies American craftsmanship at its finest. Whether cruising along the coastlines of New England or exploring the waters of the Caribbean, STARLIGHT offers unparalleled comfort and style for discerning buyers seeking the ultimate yachting experience.',
      ),
      NewsModel(
        // Выбери соответствующую категорию
        date: getRandomDate(),
        imgUrl:
            'https://www.galatiyachts.com/wp-content/uploads/Main-Blog-Photo-1630x928-19.jpg',
        title: 'MOTOR YACHT FOR SALE V',
        body: 'Performance meets luxury on board V, from the Sunseeker Predator series. Launched in 2019, V features sleek lines and reaches top speeds of 35 knots – cruising at 28 knots for fast-paced adventures on the water. A symbol of timeless sophistication in her size range, she accommodates 6 guests in 3 staterooms, including a spacious Master suite and stylish VIP. Highly optioned, her outdoor areas include sunpads forward and aft and a shaded dining area aft. An opening rooftop means life on board can be optimised for any conditions.',
      ),
      NewsModel(
        // Выбери соответствующую категорию
        date: getRandomDate(),
        imgUrl:
            'https://www.windward-islands.net/blog/wp-content/uploads/2021/07/super-yacht-copie.jpg',
        title: 'SAILING YACHT FOR SALE SJOSTORM',
        body: 'Set sail on a timeless journey with SJOSTROM, a classic Gaff rigged schooner that offers the perfect blend of traditional elegance and modern seaworthiness. Designed by Bud McIntosh and brought to life by Richmond Boatworks in the USA, SJOSTROM was originally launched in 2006, with a comprehensive two-year refit completed in 2020. SJOSTROM stands as a testament to nautical craftsmanship, featuring a wood/GRP hull meticulously constructed to ensure durability at sea. Her recent refit in 2021, guided by the vision of her current Owner, has modernised her systems and equipment, while being careful to preserve her unique charm as a classic schooner. Accommodating up to 8 guests across 4 staterooms, SJOSTROM is not just a magnificent home on the waves but also a ready-to-go charter vessel with a 5-year contract for the Fiji islands. She presents a golden opportunity for investors looking for a vessel that combines the thrill of sailing with the lucrative potential of a charter business. SJOSTROM’s interior is a harmonious blend of classic design and modern amenities. Her lower deck features a well-equipped L-shaped galley, a cosy dining area, and a spacious saloon flanked by multiple guest berths, each outfitted with air-conditioning, fans, and ensuite bathrooms. The crew quarters, located at the bow, ensure privacy and convenience with separate access from the upper deck.',
      ),
    ];

    return news;
  }

  static DateTime getRandomDate() {
    final random = Random();
    final now = DateTime.now();
    final randomDays =
        random.nextInt(30); // Генерация случайного числа от 0 до 29 для дней
    return now.subtract(Duration(days: randomDays));
  }
}
