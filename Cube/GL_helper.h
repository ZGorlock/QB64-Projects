#include <SFML/Graphics.hpp>

sf::RenderWindow App;

void gl_helper_init(int32 sx,int32 sy){
App.Create(sf::VideoMode(sx, sy, 32), "SFML Window");
App.Show(0);
App.PreserveOpenGLStates(true);
return;
}
