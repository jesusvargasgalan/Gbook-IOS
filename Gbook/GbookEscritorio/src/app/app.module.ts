import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import {environment} from '../environments/environment';
import {AngularFirestoreModule} from 'angularfire2/firestore';
import {AngularFireModule} from 'angularfire2';

import {FirestoreService} from './services/firestore.service';

import { AppComponent } from './app.component';
import { UsuariosComponent } from './components/usuarios/usuarios.component';
import { VideojuegosComponent } from './components/videojuegos/videojuegos.component';

@NgModule({
  declarations: [
    AppComponent,
    UsuariosComponent,
    VideojuegosComponent
  ],
  imports: [
    BrowserModule,
    AngularFireModule.initializeApp(environment.firebaseConfig, 'Gbook'),
    AngularFirestoreModule

  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

