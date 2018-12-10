//
//  Extensions.swift
//  youtube
//
//  Created by 陈纲 on 2018/11/10.
//  Copyright © 2018 陈纲. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb (red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView{
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        
        for(index, view) in views.enumerated(){
            
            let key = "v\(index)"
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            viewsDictionary[key] = view
        }
        
        addConstraints( NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewsDictionary))
    }
}

extension UIImageView{
    func loadImageUsingUrlString(urlString: String){
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil{
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }).resume()
    }
}
