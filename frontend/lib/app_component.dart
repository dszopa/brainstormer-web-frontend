import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'src/hero_service.dart';
import 'src/heroes_component.dart';
import 'src/dashboard_component.dart';

@Component(
  selector: 'my-app',
  template: '''
      <h1>{{title}}</h1>
      <nav>
          <a [routerLink]="['Dashboard']">Dashboard</a>
          <a [routerLink]="['Heroes']">Heroes</a>
      </nav>
      <router-outlet></router-outlet>
  ''',
  directives: const [
    ROUTER_DIRECTIVES,
  ],
  providers: const [
    HeroService,
    ROUTER_PROVIDERS,
  ],
)
@RouteConfig(const [
  const Route(
      path: '/heroes',
      name: 'Heroes',
      component: HeroesComponent
  ),
  const Route(
    path: '/dashboard',
    name: 'Dashboard',
    component: DashboardComponent,
    useAsDefault: true
  ),
])
class AppComponent {

  // Variables
  String title = 'Tour of Heroes';
}