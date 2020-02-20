//
//  ViewController.swift
//  MyNotebook
//
//  Created by Nadia Oubelaid on 14/02/2020.
//  Copyright © 2020 Nadia Oubelaid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var text = "Lets start... type something into this box"
    var textArray=[String]() //WE INITIALIZE an empty // String array
    var edit = false
    var index = 0
    let fileName = "theString.txt"
    override func viewDidLoad() {
    
        super.viewDidLoad()
        textArray.append("Hello")
        textArray.append("how are you")
        textArray.append("Lets do this")
        
        tableView.dataSource = self
        tableView.delegate = self
        readStringFromFile(fileName: fileName)
        
    }

    @IBAction func saveBtn(_ sender: Any) {
        text = textView.text
       
        if edit == true{
            textArray[index] = text
            
            
        }else{
             textArray.append(text)//add the new text to the array
        }
       
        tableView.reloadData() // til at refreshe
        textView.text=""
        edit = false
        print(text)
        saveStringToFile(str: text, fileName: fileName)
    }
    
    //hvor mange rows har vi?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count //tæller hvor mange items den har
    }
    
    //Skaber én celle for hver array item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //der skal laves en row med listen.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") //vælger en cell og tilegner en ny String til denne. Reuasble kigger på om der er nogle celler som vi allerede har brugt som er døde som nu er ledige.
        cell?.textLabel?.text = textArray[indexPath.row]
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textView.text = text
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you clicked \(indexPath.row)")
        
        textView.text=textArray[indexPath.row]
        edit=true
        index = indexPath.row
        
    }
    
    func saveStringToFile(str:String, fileName:String){
        let filePath = getDocumentDir().appendingPathComponent(fileName)
        do{
            try str.write(to: filePath, atomically: true, encoding: .utf8)
            print("yaaaaass")
        }catch{
            print("error writing string/(str)")
        }
    }
    
    
    func getDocumentDir()-> URL{
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentDir[0]
    }
    
    func readStringFromFile(fileName:String) -> String {
        let filePath = getDocumentDir().appendingPathComponent(fileName)
        do{
            let string = try String(contentsOf: filePath, encoding: .utf8)
            print(string)
            return string
        }catch{
            print("error while reading file"+fileName)
        }
        return "empty"
        
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        textArray.remove(at: index)
        textView.text = ""
        tableView.reloadData()
    }
    
}

