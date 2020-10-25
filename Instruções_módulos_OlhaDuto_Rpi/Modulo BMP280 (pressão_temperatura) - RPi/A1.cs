// Referência: https://github.com/LeivoSepp/Lesson-Temperature-BMP280
// Criando um objeto para o sensor BMP280:
 BMP280 tempAndPressure = new BMP280();

// Usando um loop while, para ler os dados do sensor a cada 1 segundo:
  while (true)
            {
                double temperature = tempAndPressure.Temperature.DegreesCelsius;
                double pressure = tempAndPressure.Pressure.Hectopascals;
                Task.Delay(1000).Wait();
            }
			
// Após a leitura dos dados, enviar esses valores medidos para o Azure:
using System;
using Windows.ApplicationModel.Background;
using Glovebox.IoT.Devices.Sensors;
using System.Threading.Tasks;

namespace LessonTemperatureBMP280
{
    public sealed class StartupTask : IBackgroundTask
    {
        BMP280 tempAndPressure = new BMP280();
        public void Run(IBackgroundTaskInstance taskInstance)
        {
            while (true)
            {
                double temperature = tempAndPressure.Temperature.DegreesCelsius;
                double pressure = tempAndPressure.Pressure.Hectopascals;
                Task.Delay(1000).Wait();
            }
        }
    }
}