import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
import { attach } from './portSubscribers';

const app = Main.embed(document.getElementById('root'));

attach(app);

registerServiceWorker();
