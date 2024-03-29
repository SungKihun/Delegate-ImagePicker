//
//  ViewController.swift
//  Delegate-ImagePicker
//
//  Created by 성기훈 on 2021/07/30.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!

    @IBAction func pick(_ sender: Any) {
        // MARK:- 이미지 피커 인스턴스
//        // 이미지 피커 컨트롤러 인스턴스 생성
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary // 이미지 소스로 사진 라이브러리 선택
//        picker.allowsEditing = true // 이미지 편집 기능 On
//        picker.delegate = self // 델리게이트 지정
//
//        // 이미지 피커 컨트롤러 실행
//        self.present(picker, animated: false)
        
        // MARK:- PH 이미지 피커 인스턴스
        let configuration = PHPickerConfiguration()
        let phPicker = PHPickerViewController(configuration: configuration)
        phPicker.delegate = self
        
        self.present(phPicker, animated: true)
    }
}

// MARK:- PH 피커 컨트롤러 델리게이트 메소드
extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: false)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        self.imgView.image = image as? UIImage
                    }
                }
        } else {
            
        }
    }
}

/*
// MARK:- 이미지 피커 컨트롤러 델리게이트 메소드
extension ViewController: UIImagePickerControllerDelegate {
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false)
        
        // 알림창 호출
        let alert = UIAlertController(title: "",
                                      message: "이미지 선택이 취소되었습니다.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인",
                                      style: .cancel))
        
        self.present(alert, animated: false)
    }
    
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            // 이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imgView.image = img
        }
    }
}
 */

// MARK:- 내비게이션 컨트롤러 델리게이트 메소드
extension ViewController: UINavigationControllerDelegate {}

// MARK:- 텍스트필드 델리게이트 메소드
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("사진 검색 시작! 추억을 찾아보아요!")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("검색이 끝났군요! 마음에 드나요?")
    }
}
