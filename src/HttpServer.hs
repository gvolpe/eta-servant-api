module HttpServer where

import GHC.Generics
import Servant
import Servant.Server
import Data.Aeson
import Network.Wai.Servlet.Handler.Jetty

data User = User {
  username :: String
} deriving (Show, Generic)

instance ToJSON User

type API = "users" :> Capture "id" Int :> Get '[JSON] User

api :: Proxy API
api = Proxy

server :: Application
server = serve api usersHandler
  where usersHandler id
          | id == 1 = return $ User "gvolpe"
          | otherwise = throwError $ err404 { errBody = "There's only one user with Id 1!" }

startServer :: IO ()
startServer = run 9000 server
