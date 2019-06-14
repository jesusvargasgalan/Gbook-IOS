import { Component, OnInit } from '@angular/core';
import { UserInterface } from '../../models/UserInterface';
import { FirestoreService} from '../../services/firestore.service';
import * as Chart from 'chart.js';


@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.css']
})
export class UsuariosComponent implements OnInit{

  arrUsuarios : UserInterface[]
  usuarios = [];
  title = 'Gbook';
  LineChart;
  countUsers = 0;
  

 
   


  constructor(private FirestoreService : FirestoreService) { }

  ngOnInit(){
    this.FirestoreService.getUsers()
   this.FirestoreService.getUsers().subscribe(users => {
     console.log(users)
    this.arrUsuarios = users;
    
   

    for(let i = 0; i < this.arrUsuarios.length ; i++){
      this.usuarios.push(this.arrUsuarios[i].Email) ;
      this.countUsers++
      console.log(this.usuarios)
    }
  });
  
}

}
