//
//  Book.h
//  racDemo
//
//  Created by xtc on 2018/1/29.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property (copy, nonatomic) NSString *title ;
@property (copy, nonatomic) NSString *publisher ;
@property (copy, nonatomic) NSString *image ;
@property (copy, nonatomic) NSString *idBook ;
@property (copy, nonatomic) NSString *url ;

//{
//    "rating": {
//        "max": 10,
//        "numRaters": 1,
//        "average": "0.0",
//        "min": 0
//    },
//    "subtitle": "Popular Text Edition: Containg the Old and New Testaments: New Revised Standard Version Bible (Anglicized) (Bible Nrsv)",
//    "author": [
//               "A"
//               ],
//    "pubdate": "1995-11-02",
//    "tags": [
//             {
//                 "count": 1,
//                 "name": "圣经版本",
//                 "title": "圣经版本"
//             }
//             ],
//    "origin_title": "",
//    "image": "https://img3.doubanio.com/mpic/s4466781.jpg",
//    "binding": "Hardcover",
//    "translator": [],
//    "catalog": "",
//    "pages": "",
//    "images": {
//        "small": "https://img3.doubanio.com/spic/s4466781.jpg",
//        "large": "https://img3.doubanio.com/lpic/s4466781.jpg",
//        "medium": "https://img3.doubanio.com/mpic/s4466781.jpg"
//    },
//    "alt": "https://book.douban.com/subject/5261803/",
//    "id": "5261803",
//    "publisher": "OUP Oxford",
//    "isbn10": "0191070009",
//    "isbn13": "9780191070006",
//    "title": "New Revised Standard Version Bible",
//    "url": "https://api.douban.com/v2/book/5261803",
//    "alt_title": "",
//    "author_intro": "",
//    "summary": "",
//    "price": "GBP 14.99"
//},

@end
