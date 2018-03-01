//
//  Constants.swift
//  newmyfood
//
//  Created by jamel on 20/02/2018.
//  Copyright © 2018 jamel. All rights reserved.
//

import Foundation
class Constants {
    struct UserDefault {
        static let PassWord = "PassWord"
    }
struct KEY {
    struct LOGIN {
        static let USERNAME = "username"
        static let PASSWORD = "password"
        
}
    struct Paquet_Text {
        static let Adresse_Espace = "العنوان"
        static let Nom_Espace = "الاسم"
    }

struct UPDATE {
    static let USERNAME = "username"
    static let EMAIL = "mail"
    static let TEL = "tel"
    static let USER_ID = "id"
    static let TOKEN = "token"
    static let PASSWORD = "password"
    static let NOM = "nom"
    static let PRENOM = "prenom"
    static let ADRESSE = "adresse"
    static let ROLE = "role"
    static let ACTIVATE = "activate"
    static let ESPACE_ID = "espace_id"

}
    struct CONTACT {
        static let SENDER_ID = "sender_id"
        static let TITLE = "title"
        static let MESSAGE = "message"
        
    }
}
    struct PlaceHolder {
        static let Contact_TextView = "نص الرسالة"
        static let Message_TextView = "أكتب رسالتك هنا"
    }
    struct URLs {
        static let PREFIX_URL = "http://alsoqub.com/Mobiles/"
        static let LOGIN = "login"
        static let UPDATE_PROFILE = "updateProfile"
        static let SIGN_UP = "inscription"
        static let CONTATCT_ADMIN = "contactAdmin"
        static let ALL_ESPACES = "allEspaces"

    }
    struct ErrorCode {
        static let GENERAL_ERROR = "100"
        static let INCORRECT_PASSWORD = "101"
        static let USER_NOT_FOUND = "102"
    }
    
    struct Messages {
        static let EMAIL_INCORRECT_FORMAT = "الرجاء التثبت من البريد الإلكتروني"
        static let USERNAME_WORD_REQUIRED = "الرجاء التثبت من اسم المستخدم"

        static let PASS_WORD_REQUIRED = "الرجاء التثبت من كلمة السّر"
        static let NAME_WORD_REQUIRED = "الرجاء التثبت من الإسم"
        static let LAST_NAME_WORD_REQUIRED = "الرجاء التثبت من اللقب"
        static let Contact_MessageTitle = "الرجاء التثبت من عنوان الرسالة"
        static let Contact_MessageContent = "الرجاء التثبت من نص الرسالة"
        static let CONTACT_SUCCESS =  "لقد تم إرسال الرسالة بنجاح"
        static let PHONNUMBER_REQUIRED = ""
        static let PROFILE_UPDATE_SUCCESS = "لقد تم حفظ بياناتك الشخصية بنجاح"
        static let PROFILE_UPDATE_FAILED = "الحفظ لم يتم, الرجاء التثبت"



        static let POP_UP_TITLE = "ماي فوود"
        static let GENERAL_ERROR = "خطأ غير معروف"
        static let POP_UP_OK_BTN =  "موافق"

    }
    struct ButtonTitle {
        static let OK = "موافق"
        static let Edit = "تعديل"
        static let Save = "حفظ"


    }
}
