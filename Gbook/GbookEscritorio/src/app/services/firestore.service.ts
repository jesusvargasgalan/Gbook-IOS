import { Injectable } from '@angular/core';
import {AngularFirestore, AngularFirestoreCollection , AngularFirestoreDocument} from 'angularfire2/firestore';
import {UserInterface} from '../models/UserInterface';
import {VideojuegoInterface} from '../models/VideojuegoInterface';
import {Observable} from 'rxjs';
import {map} from 'rxjs/operators';
import { User } from 'firebase';

@Injectable({
  providedIn: 'root'
})
export class FirestoreService {

  usersCollection : AngularFirestoreCollection<UserInterface>;
  users : Observable<UserInterface[]>;
  usersDoc : AngularFirestoreDocument<UserInterface>;


  videogamesCollection : AngularFirestoreCollection<VideojuegoInterface>;
  videogames : Observable<VideojuegoInterface[]>;
  videogamesDoc : AngularFirestoreDocument<VideojuegoInterface>;
  

  constructor( public afs: AngularFirestore) {
    this.usersCollection = afs.collection<UserInterface>('Usuarios')
    this.users = this.usersCollection.snapshotChanges().pipe(

     map(actions=> actions.map(u => {
        const data = u.payload.doc.data();
        const userId = u.payload.doc.id;
        return {userId, ... data};
      })))

     this.videogamesCollection = afs.collection<UserInterface>('Post')
     this.videogames = this.videogamesCollection.snapshotChanges().pipe(
    
         map(actions=> actions.map(u => {
            const data = u.payload.doc.data();
            const document = u.payload.doc.id;
            return {document, ... data};
          })))
    }
  

   
 

   getUsers(){

    return this.users;
    }

    getVideogames(){
      return this.videogames
    }
}
